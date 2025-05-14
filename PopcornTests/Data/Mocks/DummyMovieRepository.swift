//
//  DummyMovieRepository.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
import Foundation
@testable import Popcorn

class DummyMovieRepository: MovieRepository {
    func fetchMovieDetails(id: Int) -> AnyPublisher<Popcorn.MovieDetails, any Error> {
        fatalError()
    }
    
    func fetchLikedMovies() -> AnyPublisher<[Popcorn.Movie], any Error> {
        fatalError()
    }
    
    func storeLikedMovie(_ movie: Popcorn.Movie) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func removeLikedMovie(_ movie: Popcorn.Movie) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func fetchWatchLaterMovies() -> AnyPublisher<[Popcorn.Movie], any Error> {
        fatalError()
    }
    
    func storeWatchLaterMovie(_ movie: Popcorn.Movie) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func removeWatchLaterMovie(_ movie: Popcorn.Movie) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func fetchMovies(filtering: FilterOptions?, page: Int) -> AnyPublisher<PaginatedMovies, Error> {
        fatalError("Shouldn't be called")
    }
}
