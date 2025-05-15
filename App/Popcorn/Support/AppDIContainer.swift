//
//  AppDIContainer.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation
import PopcornCore

enum AppDI {
    static var container: AppDIContainer = .init()
}

struct AppDIContainer {
    // MARK: - Environment

    let environment: PopcornEnvironment

    // MARK: - Shared Services

    let logger: LoggerProtocol
    let networkService: NetworkService

    // MARK: - Data Sources

    let movieLocalDataSource: MovieLocalDataSource

    // MARK: - Repositories

    let movieRepository: MovieRepository

    // MARK: - Use Cases

    let fetchMoviesUseCase: FetchMoviesListUseCase
    let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    let fetchLikedMoviesUseCase: FetchLikedMoviesUseCase
    let setMovieLikedUseCase: SetMovieLikedUseCase
    let setMovieWatchLaterUseCase: SetMovieWatchLaterUseCase
    let fetchWatchLaterMoviesUseCase: FetchWatchLaterMoviesUseCase

    // MARK: - Init

    init(environment: PopcornEnvironment, logger: LoggerProtocol, networkService: NetworkService, movieLocalDataSource: MovieLocalDataSource, movieRepository: MovieRepository, fetchMoviesUseCase: FetchMoviesListUseCase, fetchMovieDetailsUseCase: FetchMovieDetailsUseCase, fetchLikedMoviesUseCase: FetchLikedMoviesUseCase, setMovieLikedUseCase: SetMovieLikedUseCase, setMovieWatchLaterUseCase: SetMovieWatchLaterUseCase, fetchWatchLaterMoviesUseCase: FetchWatchLaterMoviesUseCase) {
        self.environment = environment
        self.logger = logger
        self.networkService = networkService
        self.movieLocalDataSource = movieLocalDataSource
        self.movieRepository = movieRepository
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.fetchLikedMoviesUseCase = fetchLikedMoviesUseCase
        self.setMovieLikedUseCase = setMovieLikedUseCase
        self.setMovieWatchLaterUseCase = setMovieWatchLaterUseCase
        self.fetchWatchLaterMoviesUseCase = fetchWatchLaterMoviesUseCase
    }
}

// MARK: - Default Environment

private extension AppDIContainer {
    init() {
        self.environment = PopcornEnvironment()
        self.logger = LocalDebugger()
        self.networkService = URLSessionNetworkService(logger: logger)
        self.movieLocalDataSource = CoreDataMovieLocalDataSource(logger: logger)
        self.movieRepository = MovieRepositoryImpl(
            service: networkService,
            localDataSource: movieLocalDataSource,
            baseURL: environment.baseUrl,
            apiKey: environment.apiKey,
            logger: logger
        )
        self.fetchMoviesUseCase = FetchMoviesListUseCase(repository: movieRepository)
        self.fetchMovieDetailsUseCase = FetchMovieDetailsUseCase(repository: movieRepository)
        self.setMovieLikedUseCase = SetMovieLikedUseCase(repository: movieRepository)
        self.setMovieWatchLaterUseCase = SetMovieWatchLaterUseCase(repository: movieRepository)
        self.fetchLikedMoviesUseCase = FetchLikedMoviesUseCase(repository: movieRepository)
        self.fetchWatchLaterMoviesUseCase = FetchWatchLaterMoviesUseCase(repository: movieRepository)
    }
}
