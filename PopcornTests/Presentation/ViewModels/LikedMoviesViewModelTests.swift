//
//  LikedMoviesViewModel.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
import Foundation
@testable import Popcorn
import XCTest

final class LikedMoviesViewModelTests: BaseTestCase {
    private var coordinator: CoordinatorMock<LikeRoute>!
    private var fetchLikedMoviesUseCase: FetchLikedMoviesUseCaseMock!
    private var sut: LikedMoviesViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        coordinator = CoordinatorMock(rootRoute: .detail(id: 0))
        fetchLikedMoviesUseCase = FetchLikedMoviesUseCaseMock()
        cancellables = []
        sut = .init(
            coordinator: coordinator,
            fetchLikedMoviesUseCase: fetchLikedMoviesUseCase
        )
    }

    override func tearDown() {
        coordinator = nil
        fetchLikedMoviesUseCase = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_initialState_actionsOnly_noFetch() {
        XCTAssertEqual(fetchLikedMoviesUseCase.invocations.count, 0)
        XCTAssertNotNil(sut.state.actions.onMovieTapped)
    }

    func test_fetchLikedMovies_success_populatesMovies_andTogglesLoading() {
        // Given
        let exp = expectation(description: "fetch success")
        fetchLikedMoviesUseCase.setResult([.stub(id: 10), .stub(id: 20)])

        // When
        sut.fetchLikedMovies()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.fetchLikedMoviesUseCase.invocations.count, 1)
            XCTAssertEqual(self.sut.state.movies, [.stub(id: 10), .stub(id: 20)])
            XCTAssertFalse(self.sut.state.isLoading)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_fetchLikedMovies_failure_setsErrorState_andTogglesLoading() {
        // Given
        let exp = expectation(description: "fetch failure")
        let testError = NSError(domain: "Test", code: -1)
        fetchLikedMoviesUseCase.setResult(testError)

        // When
        sut.fetchLikedMovies()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.fetchLikedMoviesUseCase.invocations.count, 1)
            XCTAssertNotNil(self.sut.state.error)
            XCTAssertFalse(self.sut.state.isLoading)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_errorTryAgain_invokesFetchAgain() {
        // Given
        let expectation = XCTestExpectation()
        fetchLikedMoviesUseCase.setResult(NSError(domain: "", code: -1))
        sut.fetchLikedMovies()
        let firstCount = fetchLikedMoviesUseCase.invocations.count

        let stream = fetchLikedMoviesUseCase.invocationStream.sink { _ in
            guard let tryAgain = self.sut.state.error?.tryAgain else {
                XCTFail("tryAgain should be set")
                return
            }

            // When
            tryAgain()

            // Then
            XCTAssertEqual(self.fetchLikedMoviesUseCase.invocations.count, firstCount + 1)
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
