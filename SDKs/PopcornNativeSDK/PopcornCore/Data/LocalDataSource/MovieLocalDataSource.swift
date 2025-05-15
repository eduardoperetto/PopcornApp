//
//  MovieLocalDataSource.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 11/05/25.
//

import Combine
import Foundation

public protocol MovieLocalDataSource {
    func fetchLikedMovies() -> AnyPublisher<[Movie], Error>
    func storeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error>
    func removeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error>
    func isMovieLiked(movieId: Int) -> AnyPublisher<Bool, Error>

    func fetchWatchLaterMovies() -> AnyPublisher<[Movie], Error>
    func storeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error>
    func removeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error>
    func isMovieSetToWatchLater(movieId: Int) -> AnyPublisher<Bool, Error>
}
