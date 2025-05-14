//
//  FetchMovieDetailsUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Combine
import Foundation

class FetchMovieDetailsUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func invoke(movieId: Int) -> AnyPublisher<MovieDetails, any Error> {
        repository.fetchMovieDetails(id: movieId)
    }
}
