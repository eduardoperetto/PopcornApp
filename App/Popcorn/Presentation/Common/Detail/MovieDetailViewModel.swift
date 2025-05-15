//
//  MovieDetailsViewModel.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Combine
import Foundation
import PopcornCore

class MovieDetailsViewModel: ObservableObject {
    @Published var state: MovieDetailsViewState = .init()

    private let movieId: Int
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let setMovieLikedUseCase: SetMovieLikedUseCase
    private let setMovieWatchLaterUseCase: SetMovieWatchLaterUseCase
    private var requestCancellable: Set<AnyCancellable> = .init()
    private var storageCancellable: Set<AnyCancellable> = .init()

    init(
        movieId: Int,
        fetchMovieDetailsUseCase: FetchMovieDetailsUseCase,
        setMovieLikedUseCase: SetMovieLikedUseCase,
        setMovieWatchLaterUseCase: SetMovieWatchLaterUseCase
    ) {
        self.movieId = movieId
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.setMovieLikedUseCase = setMovieLikedUseCase
        self.setMovieWatchLaterUseCase = setMovieWatchLaterUseCase
        fetchMovieData()
    }

    func fetchMovieData() {
        state.isLoading = true
        fetchMovieDetailsUseCase.invoke(movieId: movieId)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] in
                self?.state.movie = $0
            }
            .store(in: &requestCancellable)
    }

    func toggleLike() {
        state.movie?.isLiked.toggle()
        guard let details = state.movie else { return }
        let movie = details.toMovie()
        let isLiked = details.isLiked
        setMovieLikedUseCase.invoke(movie, isLiked)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] in
                // Just to make sure it will override if there's a race
                self?.state.movie?.isLiked = isLiked
            }
            .store(in: &storageCancellable)
    }

    func toggleWatchLater() {
        state.movie?.isSetToWatchLater.toggle()
        guard let details = state.movie else { return }
        let movie = details.toMovie()
        let isSetToWatchLater = details.isSetToWatchLater
        setMovieWatchLaterUseCase.invoke(movie, isSetToWatchLater)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] in
                self?.state.movie?.isSetToWatchLater = isSetToWatchLater
            }
            .store(in: &storageCancellable)
    }

    private func handleError(_ error: Error) {
        state.error = .init(
            title: "Could not fetch movie",
            description: error.localizedDescription,
            tryAgain: { [weak self] in self?.fetchMovieData() }
        )
    }
}
