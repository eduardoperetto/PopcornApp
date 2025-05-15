//
//  SetMovieWatchLaterUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Combine
import Foundation

public class SetMovieWatchLaterUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func invoke(_ movie: Movie, _ watchLater: Bool) -> AnyPublisher<Void, Error> {
        if watchLater {
            return repository.storeWatchLaterMovie(movie)
        } else {
            return repository.removeWatchLaterMovie(movie)
        }
    }
}
