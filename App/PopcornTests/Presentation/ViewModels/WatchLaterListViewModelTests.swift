//
//  WatchLaterListViewModelTests.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import XCTest
import Combine
import SwiftUI
@testable import Popcorn

// MARK: - Tests

final class WatchLaterListViewModelTests: BaseTestCase {
    private var coordinator: CoordinatorMock<WatchLaterRoute>!
    private var fetchWatchLaterMoviesUseCase: FetchWatchLaterMoviesUseCaseMock!
    private var sut: WatchLaterListViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        coordinator = CoordinatorMock(rootRoute: .detail(id: 0))
        fetchWatchLaterMoviesUseCase = FetchWatchLaterMoviesUseCaseMock()
        cancellables = []
        sut = .init(
            coordinator: coordinator,
            fetchWatchLaterMoviesUseCase: fetchWatchLaterMoviesUseCase
        )
    }

    override func tearDown() {
        coordinator = nil
        fetchWatchLaterMoviesUseCase = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_initialState_actionsOnly_noFetch() {
        // Given
        // When
        // Then
        XCTAssertEqual(fetchWatchLaterMoviesUseCase.invocations.count, 0)
        XCTAssertNotNil(sut.state.actions.onMovieTapped)
    }

    func test_fetchWatchLaterMovies_success_populatesMovies_andTogglesLoading() {
        // Given
        let exp = expectation(description: "fetch success")
        fetchWatchLaterMoviesUseCase.setResult([.stub(id: 10), .stub(id: 20)])

        // When
        sut.fetchWatchLaterMovies()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.fetchWatchLaterMoviesUseCase.invocations.count, 1)
            XCTAssertEqual(self.sut.state.movies, [.stub(id: 10), .stub(id: 20)])
            XCTAssertFalse(self.sut.state.isLoading)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_fetchWatchLaterMovies_failure_setsErrorState_andTogglesLoading() {
        // Given
        let exp = expectation(description: "fetch failure")
        let testError = NSError(domain: "Test", code: -1)
        fetchWatchLaterMoviesUseCase.setResult(testError)

        // When
        sut.fetchWatchLaterMovies()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.fetchWatchLaterMoviesUseCase.invocations.count, 1)
            XCTAssertNotNil(self.sut.state.error)
            XCTAssertFalse(self.sut.state.isLoading)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_errorTryAgain_invokesFetchAgain() {
        // Given
        let expectation = XCTestExpectation()
        fetchWatchLaterMoviesUseCase.setResult(NSError(domain: "", code: -1))
        sut.fetchWatchLaterMovies()
        let firstCount = fetchWatchLaterMoviesUseCase.invocations.count

        let stream = fetchWatchLaterMoviesUseCase.invocationStream.sink { _ in
            guard let tryAgain = self.sut.state.error?.tryAgain else {
                XCTFail("tryAgain should be set")
                return
            }

            // When
            tryAgain()

            // Then
            XCTAssertEqual(self.fetchWatchLaterMoviesUseCase.invocations.count, firstCount + 1)
            expectation.fulfill()
        }
        cancellables.insert(stream)
    }

    func test_onMovieTapped_navigatesToDetailRoute() {
        // Given
        let movie = Movie.stub(id: 123)

        // When
        sut.onMovieTapped(movie)

        // Then
        XCTAssertEqual(coordinator.navigatedRoutes, [.detail(id: 123)])
    }

    func test_actions_onMovieTapped_usesCoordinator() {
        // Given
        let movie = Movie.stub(id: 456)

        // When
        sut.state.actions.onMovieTapped(movie)

        // Then
        XCTAssertEqual(coordinator.navigatedRoutes, [.detail(id: 456)])
    }
}
