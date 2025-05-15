//
//  FetchWatchLaterMoviesUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Combine
import Foundation

public class FetchWatchLaterMoviesUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func invoke() -> AnyPublisher<[Movie], any Error> {
        repository.fetchWatchLaterMovies()
    }
}
