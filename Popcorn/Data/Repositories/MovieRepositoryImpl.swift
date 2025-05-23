//
//  MovieRepositoryImpl.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Combine
import Foundation

final class MovieRepositoryImpl: MovieRepository {
    private let service: NetworkService
    private let baseURL: URL
    private let logger: LoggerProtocol
    private let apiKey: String
    private let localDataSource: MovieLocalDataSource

    init(
        service: NetworkService,
        localDataSource: MovieLocalDataSource,
        baseURL: URL,
        apiKey: String,
        logger: LoggerProtocol
    ) {
        self.service = service
        self.localDataSource = localDataSource
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.logger = logger
    }

    func fetchMovies(filtering filterOptions: FilterOptions? = nil, page: Int) -> AnyPublisher<PaginatedMovies, Error> {
        let endpoint = APIEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            route: MoviesAPIRoute.discoverMovies(filter: filterOptions, page: page)
        )
        return performRequest(
            endpoint: endpoint,
            responseType: MovieListResponseDTO.self,
            mapper: { $0.toDomain() }
        )
    }

    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetails, Error> {
        let endpoint = APIEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            route: MoviesAPIRoute.movieDetails(id: id)
        )
        return performRequest(
            endpoint: endpoint,
            responseType: MovieDetailsResponseDTO.self,
            mapper: { $0 }
        )
        .zip(
            fetchMovieProviders(id: id),
            localDataSource.isMovieLiked(movieId: id),
            localDataSource.isMovieSetToWatchLater(movieId: id)
        )
        .map { movieDetails, providers, isLiked, isSetToWatchLater in
            movieDetails.toDomain(providers: providers, isLiked: isLiked, isSetToWatchLater: isSetToWatchLater)
        }.eraseToAnyPublisher()
    }

    func fetchMovieProviders(id: Int) -> AnyPublisher<Set<MovieProvider>, Error> {
        let endpoint = APIEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            route: MoviesAPIRoute.movieProviders(id: id)
        )
        return performRequest(
            endpoint: endpoint,
            responseType: MovieProvidersResponseDTO.self,
            mapper: { $0.toDomain() }
        )
    }

    func fetchLikedMovies() -> AnyPublisher<[Movie], Error> {
        localDataSource.fetchLikedMovies()
    }

    func storeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        localDataSource.storeLikedMovie(movie)
    }

    func removeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        localDataSource.removeLikedMovie(movie)
    }

    func fetchWatchLaterMovies() -> AnyPublisher<[Movie], Error> {
        localDataSource.fetchWatchLaterMovies()
    }

    func storeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        localDataSource.storeWatchLaterMovie(movie)
    }

    func removeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        localDataSource.removeWatchLaterMovie(movie)
    }

    private func performRequest<T: Decodable, U>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        mapper: @escaping (T) -> U
    ) -> AnyPublisher<U, Error> {
        return service.request(endpoint, responseType: responseType)
            .mapError { $0 as Error }
            .map { mapper($0) }
            .eraseToAnyPublisher()
    }
}
