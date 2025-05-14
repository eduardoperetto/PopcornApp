//
//  MovieDetailViewModel.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn
import XCTest

final class MovieDetailsViewModelTests: BaseTestCase {
    private var fetchMovieDetailsUseCase: FetchMovieDetailsUseCaseMock!
    private var setMovieLikedUseCase: SetMovieLikedUseCaseMock!
    private var setMovieWatchLaterUseCase: SetMovieWatchLaterUseCaseMock!
    private var sut: MovieDetailsViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        fetchMovieDetailsUseCase = FetchMovieDetailsUseCaseMock()
        setMovieLikedUseCase = SetMovieLikedUseCaseMock()
        setMovieWatchLaterUseCase = SetMovieWatchLaterUseCaseMock()
        cancellables = []
        sut = .init(
            movieId: 123,
            fetchMovieDetailsUseCase: fetchMovieDetailsUseCase,
            setMovieLikedUseCase: setMovieLikedUseCase,
            setMovieWatchLaterUseCase: setMovieWatchLaterUseCase
        )
    }

    override func tearDown() {
        fetchMovieDetailsUseCase = nil
        setMovieLikedUseCase = nil
        setMovieWatchLaterUseCase = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchMovieData_success_setsState() {
        // Given
        let exp = expectation(description: "movie details loaded")
        fetchMovieDetailsUseCase.setResult(.stub(id: 123))

        // When
        sut.fetchMovieData()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.state.movie?.id, 123)
            XCTAssertFalse(self.sut.state.isLoading)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_fetchMovieData_failure_setsError() {
        // Given
        let exp = expectation(description: "error handled")
        fetchMovieDetailsUseCase.setResult(NSError(domain: "", code: -1))

        // When
        sut.fetchMovieData()

        // Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.sut.state.error)
            XCTAssertFalse(self.sut.state.isLoading)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_toggleLike_storesLikeState() {
        // Given
        sut.state.movie = .stub(id: 123, isLiked: false)
        let exp = expectation(description: "like toggled")
        setMovieLikedUseCase.setResult(success: true)

        // When
        sut.toggleLike()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.setMovieLikedUseCase.invocations.last?.isLiked, true)
            XCTAssertEqual(self.setMovieLikedUseCase.invocations.last?.movie.id, 123)
            XCTAssertTrue(self.sut.state.movie?.isLiked ?? false)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_toggleWatchLater_storesWatchLaterState() {
        // Given
        sut.state.movie = .stub(id: 123, isSetToWatchLater: false)
        let exp = expectation(description: "watch later toggled")
        setMovieWatchLaterUseCase.setResult(success: true)

        // When
        sut.toggleWatchLater()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.setMovieWatchLaterUseCase.invocations.last?.watchLater, true)
            XCTAssertEqual(self.setMovieWatchLaterUseCase.invocations.last?.movie.id, 123)
            XCTAssertTrue(self.sut.state.movie?.isSetToWatchLater ?? false)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_toggleLike_onFailure_setsError() {
        // Given
        let exp = expectation(description: "error handled")
        sut.state.movie = .stub(id: 123, isLiked: false)
        setMovieLikedUseCase.setResult(NSError(domain: "", code: -1))

        // When
        sut.toggleLike()

        // Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.sut.state.error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_toggleWatchLater_onFailure_setsError() {
        // Given
        let exp = expectation(description: "error handled")
        sut.state.movie = .stub(id: 123, isSetToWatchLater: false)
        setMovieWatchLaterUseCase.setResult(NSError(domain: "", code: -1))

        // When
        sut.toggleWatchLater()

        // Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.sut.state.error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
