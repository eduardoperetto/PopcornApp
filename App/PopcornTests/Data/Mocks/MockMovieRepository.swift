//
//  MockMovieRepository.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn

final class MockMovieRepository: MovieRepository {
    var fetchMoviesCalls: [(filtering: FilterOptions?, page: Int)] = []
    var fetchDetailsCalls: [Int] = []

    // Return values
    var moviesPage: PaginatedMovies = .stub()
    var details: MovieDetails = .init(
        id: 0, title: "", tagline: "", overview: "",
        releaseDate: "", genres: [], runtime: 0,
        budget: 0, revenue: 0, voteAverage: 0,
        voteCount: 0, backdropPath: nil, posterPath: nil,
        homepage: nil, productionCompanies: [],
        spokenLanguages: [], status: "", movieProviders: [],
        isLiked: false, isSetToWatchLater: false
    )

    func fetchMovies(filtering: FilterOptions?, page: Int) -> AnyPublisher<PaginatedMovies, Error> {
        fetchMoviesCalls.append((filtering, page))
        return Just(moviesPage)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetails, Error> {
        fetchDetailsCalls.append(id)
        return Just(details)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchLikedMovies() -> AnyPublisher<[Movie], Error> {
        // Delegate to local data source or custom stub
        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func storeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func removeLikedMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchWatchLaterMovies() -> AnyPublisher<[Movie], Error> {
        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func storeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func removeWatchLaterMovie(_ movie: Movie) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
