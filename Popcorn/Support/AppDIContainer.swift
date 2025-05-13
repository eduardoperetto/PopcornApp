//
//  AppDIContainer.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

final class AppDIContainer {
    // MARK: - Singleton

    static let shared = AppDIContainer()

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

    private init() {
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
