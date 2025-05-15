//
//  DiscoverViewModel.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Combine
import Foundation
import PopcornCore

final class DiscoverViewModel: FilterableViewModel {
    private weak var coordinator: Coordinator<DiscoverRoute>?
    @Published var state: MovieListViewState = .init()
    private let fetchMoviesListUseCase: FetchMoviesListUseCase
    private var requestCancellable: Set<AnyCancellable> = .init()
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var currentLoadedMovies: [Movie] = []

    init(
        coordinator: Coordinator<DiscoverRoute>,
        fetchMoviesListUseCase: FetchMoviesListUseCase
    ) {
        self.coordinator = coordinator
        self.fetchMoviesListUseCase = fetchMoviesListUseCase
        super.init()
        setupActions()
    }

    func fetchMovies() {
        guard !state.isLoading else { return }
        resetMoviesRequest()
        fetchMoviesListUseCase.invoke(filters: state.selectedFilters, page: currentPage)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                self.totalPages = $0.totalPages
                self.currentLoadedMovies = $0.movies
                self.updateViewWithLoadedMovies()
            }
            .store(in: &requestCancellable)
    }

    func loadMoreMoviesIfNeeded(currentMovie: Movie) {
        guard
            !state.isLoading,
            !state.isLoadingMore,
            currentPage < totalPages,
            let lastMovie = state.movies.last,
            currentMovie == lastMovie
        else { return }

        loadMoreMovies()
    }

    func onMovieTapped(_ movie: Movie) {
        coordinator?.navigate(to: .detail(id: movie.id))
    }

    override func onFiltersApplied(_ filters: FilterOptions) {
        super.onFiltersApplied(filters)
        state.selectedFilters = filters
        fetchMovies()
    }

    private func updateViewWithLoadedMovies() {
        setMoviesState(currentLoadedMovies)
    }

    private func setupActions() {
        state.actions = MovieListViewState.Actions(
            onMovieTapped: { [weak self] in self?.onMovieTapped($0) },
            onMovieCellAppeared: { [weak self] in self?.loadMoreMoviesIfNeeded(currentMovie: $0) }
        )
    }

    private func setMoviesState(_ movies: [Movie]) {
        state.movies = movies
    }

    private func loadMoreMovies() {
        state.isLoadingMore = true
        requestCancellable.forEach { $0.cancel() }
        currentPage += 1
        fetchMoviesListUseCase.invoke(filters: state.selectedFilters, page: currentPage)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.state.isLoadingMore = false
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] in
                self?.handleLoadMoreResponse($0)
            }
            .store(in: &requestCancellable)
    }

    private func resetMoviesRequest() {
        requestCancellable.forEach { $0.cancel() }
        currentPage = 1
        state.isLoading = true
        state.isLoadingMore = false
    }

    private func handleLoadMoreResponse(_ paginatedMovies: PaginatedMovies) {
        let newMovies = paginatedMovies.movies.filter {
            !currentLoadedMovies.map(\.id).contains($0.id)
        }
        currentLoadedMovies.append(contentsOf: newMovies)
        totalPages = paginatedMovies.totalPages
        updateViewWithLoadedMovies()
    }

    private func handleError(_ error: Error) {
        state.error = .init(
            title: "Could not fetch movies",
            description: error.localizedDescription,
            tryAgain: { [weak self] in self?.fetchMovies() }
        )
    }
}
