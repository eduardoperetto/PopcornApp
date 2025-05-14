//
//  FetchLikedMoviesUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Combine
import Foundation

class FetchLikedMoviesUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func invoke() -> AnyPublisher<[Movie], any Error> {
        repository.fetchLikedMovies()
    }
}
