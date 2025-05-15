//
//  MovieRepositoryImplTests.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 14/05/25.
//

import Combine
@testable import Popcorn
import PopcornCore
import XCTest

final class MovieRepositoryImplTests: BaseTestCase {
    private var service: ClosureNetworkService!
    private var localDataSource: MockMovieLocalDataSource!
    private var repo: MovieRepositoryImpl!
    private var cancellables: Set<AnyCancellable>!
    private let baseURL = URL(string: "https://api.test.com")!
    private let apiKey = "key"
    private let logger = MockLogger()

    override func setUp() {
        super.setUp()
        service = ClosureNetworkService()
        localDataSource = MockMovieLocalDataSource()
        repo = MovieRepositoryImpl(
            service: service,
            localDataSource: localDataSource,
            baseURL: baseURL,
            apiKey: apiKey,
            logger: logger
        )
        cancellables = []
    }

    override func tearDown() {
        service = nil
        localDataSource = nil
        repo = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchMovies_mapsResponseToDomain() {
        // Given
        let dto = MovieListResponseDTO.stub(
            page: 2,
            results: [.stub(id: 11), .stub(id: 22)],
            totalPages: 5,
            totalResults: 10
        )
        service.handler = { _, _ in
            Just(dto)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        let exp = expectation(description: "fetchMovies")

        // When
        repo.fetchMovies(filtering: .stub(), page: 2)
            .sink(receiveCompletion: { _ in }, receiveValue: { paginated in
                // Then
                XCTAssertEqual(paginated.page, 2)
                XCTAssertEqual(paginated.totalPages, 5)
                XCTAssertEqual(paginated.totalResults, 10)
                XCTAssertEqual(paginated.movies.map(\.id), [11, 22])
                exp.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_fetchMovieProviders_mapsResponseToDomain() {
        // Given
        let providers = [MovieProviderDTO.stub(providerId: 1), MovieProviderDTO.stub(providerId: 2)]
        let dto = MovieProvidersResponseDTO.stub(
            results: ["US": .stub(flatrate: providers)]
        )
        service.handler = { _, _ in
            Just(dto)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        let exp = expectation(description: "fetchProviders")

        // When
        repo.fetchMovieProviders(id: 99)
            .sink(receiveCompletion: { _ in }, receiveValue: { providers in
                // Then
                let ids = providers.map { $0.id }
                XCTAssertEqual(Set(ids), Set([1, 2]))
                exp.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_fetchMovieDetails_combinesAllData() {
        // Given
        let detailsDTO = MovieDetailsResponseDTO.stub(id: 5)
        let providersDTO = MovieProvidersResponseDTO.stub(
            results: ["US": .stub(flatrate: [.stub(providerId: 7)])]
        )
        service.handler = { _, type in
            if type == MovieDetailsResponseDTO.self {
                return Just(detailsDTO)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            } else {
                return Just(providersDTO)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
        }

        // Local
        localDataSource.likedMovies = [Movie.stub(id: 5)]
        localDataSource.watchLaterMovies = []
        let exp = expectation(description: "fetchDetails")

        // When
        repo.fetchMovieDetails(id: 5)
            .sink(receiveCompletion: { _ in }, receiveValue: { details in
                // Then
                XCTAssertEqual(details.id, 5)
                XCTAssertEqual(details.movieProviders.map(\.id), [7])
                XCTAssertTrue(details.isLiked)
                XCTAssertFalse(details.isSetToWatchLater)
                exp.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_localStorage_passthrough() {
        // Given
        let movie = Movie.stub(id: 3)
        localDataSource.likedMovies = [movie]
        localDataSource.watchLaterMovies = [movie]

        // When & Then
        repo.fetchLikedMovies()
            .sink(receiveCompletion: { _ in }, receiveValue: { movies in
                XCTAssertEqual(movies, [movie])
            }).store(in: &cancellables)

        XCTAssertEqual(localDataSource.fetchLikedCalls, 1)

        repo.storeLikedMovie(movie)
            .sink(receiveCompletion: { _ in }, receiveValue: {}).store(in: &cancellables)
        XCTAssertEqual(localDataSource.storeLikedCalls, [movie])

        repo.removeLikedMovie(movie)
            .sink(receiveCompletion: { _ in }, receiveValue: {}).store(in: &cancellables)
        XCTAssertEqual(localDataSource.removeLikedCalls, [movie])

        repo.fetchWatchLaterMovies()
            .sink(receiveCompletion: { _ in }, receiveValue: { movies in
                XCTAssertEqual(movies, [movie])
            }).store(in: &cancellables)
        XCTAssertEqual(localDataSource.fetchWatchLaterCalls, 1)

        repo.storeWatchLaterMovie(movie)
            .sink(receiveCompletion: { _ in }, receiveValue: {}).store(in: &cancellables)
        XCTAssertEqual(localDataSource.storeWatchLaterCalls, [movie])

        repo.removeWatchLaterMovie(movie)
            .sink(receiveCompletion: { _ in }, receiveValue: {}).store(in: &cancellables)
        XCTAssertEqual(localDataSource.removeWatchLaterCalls, [movie])
    }
}

final class ClosureNetworkService: NetworkService {
    var handler: (APIEndpoint, any Decodable.Type) -> AnyPublisher<Any, NetworkError> = { _, _ in
        Empty().eraseToAnyPublisher()
    }

    func request<T>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, NetworkError> where T: Decodable {
        handler(endpoint, responseType as any Decodable.Type)
            .tryMap { value in
                guard let typed = value as? T else {
                    throw NetworkError.decodingFailed
                }
                return typed
            }
            .mapError { $0 as? NetworkError ?? .decodingFailed }
            .eraseToAnyPublisher()
    }
}

extension MovieListResponseDTO {
    static func stub(
        page: Int = 1,
        results: [MovieDTO] = [MovieDTO.stub()],
        totalPages: Int = 1,
        totalResults: Int = 0
    ) -> MovieListResponseDTO {
        MovieListResponseDTO(
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults
        )
    }
}

// MARK: - MovieProvidersResponseDTO Stub

extension MovieProvidersResponseDTO {
    static func stub(
        results: [String: ProvidersListDTO] = ["US": .stub()]
    ) -> MovieProvidersResponseDTO {
        MovieProvidersResponseDTO(
            results: results
        )
    }
}

extension MovieProvidersResponseDTO.ProvidersListDTO {
    static func stub(
        flatrate: [MovieProviderDTO]? = [MovieProviderDTO.stub()],
        buy: [MovieProviderDTO]? = nil
    ) -> MovieProvidersResponseDTO.ProvidersListDTO {
        MovieProvidersResponseDTO.ProvidersListDTO(
            flatrate: flatrate,
            buy: buy
        )
    }
}

// MARK: - MovieDetailsResponseDTO Stub

extension MovieDetailsResponseDTO {
    static func stub(
        id: Int = 1,
        title: String = "Title",
        tagline: String = "Tagline",
        overview: String = "Overview",
        releaseDate: String = "2024-01-01",
        genres: [GenreDTO] = [GenreDTO.stub()],
        runtime: Int? = 120,
        budget: Double = 100_000,
        revenue: Double = 200_000,
        voteAverage: Double = 8.0,
        voteCount: Int = 100,
        backdropPath: String? = nil,
        posterPath: String? = nil,
        homepage: String? = nil,
        productionCompanies: [ProductionCompanyDTO] = [ProductionCompanyDTO.stub()],
        spokenLanguages: [SpokenLanguageDTO] = [SpokenLanguageDTO.stub()],
        status: String = "Released"
    ) -> MovieDetailsResponseDTO {
        MovieDetailsResponseDTO(
            id: id,
            title: title,
            tagline: tagline,
            overview: overview,
            releaseDate: releaseDate,
            genres: genres,
            runtime: runtime,
            budget: budget,
            revenue: revenue,
            voteAverage: voteAverage,
            voteCount: voteCount,
            backdropPath: backdropPath,
            posterPath: posterPath,
            homepage: homepage,
            productionCompanies: productionCompanies,
            spokenLanguages: spokenLanguages,
            status: status
        )
    }
}

// MARK: - Supporting DTO Stubs

extension MovieDTO {
    static func stub(
        id: Int = 1,
        title: String = "Title",
        overview: String = "Overview",
        posterPath: String? = nil,
        backdropPath: String? = nil,
        releaseDate: String = "2024-01-01",
        voteAverage: Double = 5.0,
        voteCount: Int = 10,
        popularity: Double = 1.0,
        originalLanguage: String? = "en",
        adult: Bool = false,
        video: Bool = false
    ) -> MovieDTO {
        MovieDTO(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount,
            popularity: popularity,
            originalLanguage: originalLanguage,
            adult: adult,
            video: video
        )
    }
}

extension MovieProviderDTO {
    static func stub(
        providerId: Int = 1,
        providerName: String = "Provider",
        logoPath: String = "path.jpg"
    ) -> MovieProviderDTO {
        MovieProviderDTO(
            providerId: providerId,
            providerName: providerName,
            logoPath: logoPath
        )
    }
}

extension ProductionCompanyDTO {
    static func stub(
        id: Int = 1,
        name: String = "Company",
        logoPath: String? = nil,
        originCountry: String = "US"
    ) -> ProductionCompanyDTO {
        ProductionCompanyDTO(
            id: id,
            name: name,
            logoPath: logoPath,
            originCountry: originCountry
        )
    }
}

extension GenreDTO {
    static func stub(
        id: Int = 1,
        name: String = "Genre"
    ) -> GenreDTO {
        GenreDTO(
            id: id,
            name: name
        )
    }
}

extension SpokenLanguageDTO {
    static func stub(
        englishName: String = "English",
        name: String = "English",
        isoCode: String = "en"
    ) -> SpokenLanguageDTO {
        SpokenLanguageDTO(
            englishName: englishName,
            name: name,
            isoCode: isoCode
        )
    }
}
