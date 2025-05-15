//
//  FetchMovieDetailsUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Combine
import Foundation

public class FetchMovieDetailsUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func invoke(movieId: Int) -> AnyPublisher<MovieDetails, any Error> {
        repository.fetchMovieDetails(id: movieId)
    }
}
