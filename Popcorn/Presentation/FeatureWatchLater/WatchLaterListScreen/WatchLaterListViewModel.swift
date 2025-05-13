//
//  WatchLaterListViewModel.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Combine
import Foundation

final class WatchLaterListViewModel: ObservableObject {
    private weak var coordinator: Coordinator<WatchLaterRoute>?
    @Published var state: MovieListViewState = .init()
    private let fetchWatchLaterMoviesUseCase: FetchWatchLaterMoviesUseCase
    private var storageCancellable: Set<AnyCancellable> = .init()

    init(
        coordinator: Coordinator<WatchLaterRoute>,
        fetchWatchLaterMoviesUseCase: FetchWatchLaterMoviesUseCase
    ) {
        self.coordinator = coordinator
        self.fetchWatchLaterMoviesUseCase = fetchWatchLaterMoviesUseCase
        setupActions()
    }

    func fetchWatchLaterMovies() {
        state.isLoading = true
        fetchWatchLaterMoviesUseCase.invoke()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] movies in
                self?.state.movies = movies
            }
            .store(in: &storageCancellable)
    }

    func onMovieTapped(_ movie: Movie) {
        coordinator?.navigate(to: .detail(id: movie.id))
    }

    private func setupActions() {
        state.actions = .init(onMovieTapped: { [weak self] in self?.onMovieTapped($0) })
    }

    private func handleError(_ error: Error) {
        state.error = .init(
            title: "Could not fetch movies",
            description: error.localizedDescription,
            tryAgain: { [weak self] in self?.fetchWatchLaterMovies() }
        )
    }
}
