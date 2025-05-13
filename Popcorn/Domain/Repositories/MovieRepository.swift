//
//  MovieRepository.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Combine

protocol MovieRepository {
    func fetchMovies(filtering: FilterOptions?, page: Int) -> AnyPublisher<PaginatedMovies, Error>
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetails, Error>

    func fetchLikedMovies() -> AnyPublisher<[Movie], Error>
    func storeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error>
    func removeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error>

    func fetchWatchLaterMovies() -> AnyPublisher<[Movie], Error>
    func storeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error>
    func removeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error>
}
