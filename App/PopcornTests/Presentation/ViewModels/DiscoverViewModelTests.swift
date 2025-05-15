//
//  DiscoverViewModelTests.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
import Foundation
@testable import Popcorn
import XCTest

final class DiscoverViewModelTests: BaseTestCase {
    private var coordinator: CoordinatorMock<DiscoverRoute>!
    private var fetchMoviesListUseCase: FetchMoviesListUseCaseMock!
    private var sut: DiscoverViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        AppDI.container = .stub()
        coordinator = CoordinatorMock(rootRoute: .detail(id: 0))
        fetchMoviesListUseCase = FetchMoviesListUseCaseMock()
        cancellables = []
        sut = .init(
            coordinator: coordinator,
            fetchMoviesListUseCase:
            fetchMoviesListUseCase
        )
    }

    override func tearDown() {
        coordinator = nil
        fetchMoviesListUseCase = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_init_triggersInitialFetch_andSetsActions() {
        // Given
        let exp = expectation(description: "initial fetch")
        fetchMoviesListUseCase.setResult(.stub(page: 1, totalPages: 2, movies: [.stub(id: 42)]))

        // When
        sut.fetchMovies()

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.fetchMoviesListUseCase.invocations.first?.page, 1)
            XCTAssertEqual(self.sut.state.movies, [.stub(id: 42)])
            XCTAssertFalse(self.sut.state.isLoading)
            self.sut.state.actions.onMovieTapped(.stub(id: 99))
            XCTAssertEqual(self.coordinator.navigatedRoutes.last, .detail(id: 99))
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_fetchMovies_whenAlreadyLoading_doesNotInvokeUseCaseAgain() {
        // Given
        sut.state.isLoading = true
        let initialCount = fetchMoviesListUseCase.invocations.count

        // When
        sut.fetchMovies()

        // Then
        XCTAssertEqual(fetchMoviesListUseCase.invocations.count, initialCount)
    }

    func test_fetchMovies_onFailure_setsErrorState() {
        // Given
        let exp = expectation(description: "error handled")
        fetchMoviesListUseCase.setResult(NSError(domain: "", code: -1))

        // When
        sut.fetchMovies()

        // Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.sut.state.error)
            XCTAssertEqual(self.sut.state.isLoading, false)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_loadMoreMoviesIfNeeded_atLastMovie_loadsMore() {
        // Given
        let expectation = XCTestExpectation(description: "Loaded more")
        fetchMoviesListUseCase.setResult(.stub(page: 1, totalPages: 2, movies: [.stub(id: 1), .stub(id: 2)]))
        sut.fetchMovies()

        fetchMoviesListUseCase.setResult(.stub(page: 2, totalPages: 2, movies: [.stub(id: 3), .stub(id: 4)]))

        // When
        sut.state.actions.onMovieCellAppeared(.stub(id: 2))

        // Then
        _ = fetchMoviesListUseCase.invocationStream.sink { invocation in
            XCTAssertEqual(invocation.page, 2)
            expectation.fulfill()
        }
    }

    func test_loadMoreMoviesIfNeeded_notLast_noLoad() {
        // Given
        fetchMoviesListUseCase.setResult(.stub(page: 1, totalPages: 2, movies: [.stub(id: 1), .stub(id: 2)]))
        let initialCount = fetchMoviesListUseCase.invocations.count

        // When
        sut.loadMoreMoviesIfNeeded(currentMovie: .stub(id: 1))

        // Then
        XCTAssertEqual(fetchMoviesListUseCase.invocations.count, initialCount)
    }

    func test_onMovieTapped_navigatesToDetailRoute() {
        // Given
        let movie = Movie.stub(id: 123)

        // When
        sut.onMovieTapped(movie)

        // Then
        XCTAssertEqual(coordinator.navigatedRoutes, [.detail(id: 123)])
    }

    func test_onFiltersApplied_resetsAndFetches() {
        // Given
        let newFilters = FilterOptions.stub(movieGenre: .init(id: 0, name: "Action"))

        // When
        sut.applyFilters(newFilters)

        // Then
        XCTAssertEqual(fetchMoviesListUseCase.invocations.first?.filters, newFilters)
    }
}
