//
//  MockMovieLocalDataSource.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn

final class MockMovieLocalDataSource: MovieLocalDataSource {
    var likedMovies: [Movie] = []
    var watchLaterMovies: [Movie] = []

    private(set) var fetchLikedCalls = 0
    private(set) var storeLikedCalls: [Movie] = []
    private(set) var removeLikedCalls: [Movie] = []
    private(set) var checkLikedCalls: [Int] = []

    private(set) var fetchWatchLaterCalls = 0
    private(set) var storeWatchLaterCalls: [Movie] = []
    private(set) var removeWatchLaterCalls: [Movie] = []
    private(set) var checkWatchLaterCalls: [Int] = []

    func fetchLikedMovies() -> AnyPublisher<[Movie], Error> {
        fetchLikedCalls += 1
        return Just(likedMovies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func storeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        storeLikedCalls.append(movie)
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func removeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        removeLikedCalls.append(movie)
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func isMovieLiked(movieId: Int) -> AnyPublisher<Bool, Error> {
        checkLikedCalls.append(movieId)
        return Just(likedMovies.contains(where: { $0.id == movieId }))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchWatchLaterMovies() -> AnyPublisher<[Movie], Error> {
        fetchWatchLaterCalls += 1
        return Just(watchLaterMovies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func storeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        storeWatchLaterCalls.append(movie)
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func removeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        removeWatchLaterCalls.append(movie)
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func isMovieSetToWatchLater(movieId: Int) -> AnyPublisher<Bool, Error> {
        checkWatchLaterCalls.append(movieId)
        return Just(watchLaterMovies.contains(where: { $0.id == movieId }))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
