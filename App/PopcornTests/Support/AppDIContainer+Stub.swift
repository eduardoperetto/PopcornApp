//
//  AppDIContainer+Stub.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

@testable import Popcorn
import PopcornCore

extension AppDIContainer {
    static func stub(
        environment: PopcornEnvironment = .mock,
        logger: LoggerProtocol = MockLogger(),
        networkService: NetworkService = MockNetworkService(),
        movieLocalDataSource: MovieLocalDataSource = MockMovieLocalDataSource(),
        movieRepository: MovieRepository = MockMovieRepository(),
        fetchMoviesUseCase: FetchMoviesListUseCase = .init(repository: MockMovieRepository()),
        fetchMovieDetailsUseCase: FetchMovieDetailsUseCase = .init(repository: MockMovieRepository()),
        fetchLikedMoviesUseCase: FetchLikedMoviesUseCase = .init(repository: MockMovieRepository()),
        setMovieLikedUseCase: SetMovieLikedUseCase = .init(repository: MockMovieRepository()),
        setMovieWatchLaterUseCase: SetMovieWatchLaterUseCase = .init(repository: MockMovieRepository()),
        fetchWatchLaterMoviesUseCase: FetchWatchLaterMoviesUseCase = .init(repository: MockMovieRepository())
    ) -> AppDIContainer {
        .init(
            environment: environment,
            logger: logger,
            networkService: networkService,
            movieLocalDataSource: movieLocalDataSource,
            movieRepository: movieRepository,
            fetchMoviesUseCase: fetchMoviesUseCase,
            fetchMovieDetailsUseCase: fetchMovieDetailsUseCase,
            fetchLikedMoviesUseCase: fetchLikedMoviesUseCase,
            setMovieLikedUseCase: setMovieLikedUseCase,
            setMovieWatchLaterUseCase: setMovieWatchLaterUseCase,
            fetchWatchLaterMoviesUseCase: fetchWatchLaterMoviesUseCase
        )
    }
}
