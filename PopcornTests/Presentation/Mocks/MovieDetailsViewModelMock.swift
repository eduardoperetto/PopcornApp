//
//  MovieDetailsViewModelMock.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 14/05/25.
//

@testable import Popcorn

class MovieDetailsViewModelMock: MovieDetailsViewModel {
    init(state: MovieDetailsViewState) {
        super.init(movieId: 0, fetchMovieDetailsUseCase: FetchMovieDetailsUseCaseMock(), setMovieLikedUseCase: SetMovieLikedUseCaseMock(), setMovieWatchLaterUseCase: SetMovieWatchLaterUseCaseMock())
        self.state = state
    }

    override func fetchMovieData() {}
}
