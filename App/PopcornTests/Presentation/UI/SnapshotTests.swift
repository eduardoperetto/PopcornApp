//
//  SnapshotTests.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 14/05/25.
//

@testable import Popcorn
import SnapshotTesting
import SwiftUI
import XCTest

@MainActor
final class SnapshotTests: BaseTestCase {
    private let deviceConfig = ViewImageConfig.iPhone13

    func test_MovieItemView() throws {
        // Given
        let movie = Movie.stub(id: 1, title: "Test Movie", overview: "Overview", posterPath: nil, voteAverage: 7.8)
        let view = MovieItemView(movie: movie)
        // Then
        assertSnapshot(of: view, as: .image(layout: .fixed(width: 150, height: 200)), record: false)
    }

    func test_MoviesListView() throws {
        // Given
        let movies = (0 ..< 4).map { Movie.stub(id: $0, title: "Title \($0)", overview: "", posterPath: nil, voteAverage: Double($0)) }
        let state = MovieListViewState(movies: movies, isLoadingMore: true)
        let view = MoviesListView(state: .constant(state))
        // Then
        assertSnapshot(of: view, as: .image(layout: .fixed(width: 375, height: 600)), record: false)
    }

    func test_FilterChipView() throws {
        // Given
        let view = FilterChipView(icon: Image(systemName: "slider.horizontal.3"), description: "Filter", onTap: {}, bgColor: .blue, foregroundColor: .white)
        // Then
        assertSnapshot(of: view, as: .image(layout: .fixed(width: 120, height: 40)), record: false)
    }

    func test_MovieDetailsView_loading() throws {
        // Given
        let state = MovieDetailsViewState(movie: nil, error: nil, isLoading: true)
        let vm = MovieDetailsViewModelMock(state: state)
        let view = MovieDetailsView(viewModel: vm)
        // Then
        assertSnapshot(of: view, as: .image(layout: .device(config: deviceConfig)), record: false)
    }

    func test_MovieDetailsView_content() throws {
        // Given
        let details = MovieDetails.stub()
        let state = MovieDetailsViewState(movie: details, error: nil, isLoading: false)
        let vm = MovieDetailsViewModelMock(state: state)
        let view = NavigationView { MovieDetailsView(viewModel: vm) }
        // Then
        assertSnapshot(of: view, as: .image(layout: .device(config: deviceConfig)), record: false)
    }

    func test_MovieDetailsView_error() throws {
        // Given
        let errorState = ErrorViewState(title: "Error", description: "Failed to load", tryAgain: nil)
        let state = MovieDetailsViewState(movie: nil, error: errorState, isLoading: false)
        let vm = MovieDetailsViewModelMock(state: state)
        let view = MovieDetailsView(viewModel: vm)
        // Then
        assertSnapshot(of: view, as: .image(layout: .device(config: deviceConfig)), record: false)
    }

    func test_FilterSheetView_defaultState() throws {
        // Given
        let viewModel = FilterableViewModel()
        let view = FilterSheetView(viewModel: viewModel)

        // Then
        assertSnapshot(of: view, as: .image(layout: .device(config: deviceConfig)), record: false)
    }

    func test_FilterSheetView_withAppliedFilters() throws {
        // Given
        let viewModel = FilterableViewModel()
        let customFilters = FilterOptions.stub(
            language: .es,
            primaryReleaseYear: 2022,
            releaseDateRange: DateRangeFilter(start: "2021-01-01", end: "2021-12-31"),
            sortBy: .voteAverageDesc,
            voteRange: RangeFilter(min: 2.0, max: 9.0),
            movieGenre: MovieGenre(id: 3, name: "Thriller")
        )
        viewModel.applyFilters(customFilters)
        let view = FilterSheetView(viewModel: viewModel)

        // Then
        assertSnapshot(of: view, as: .image(layout: .device(config: deviceConfig)), record: false)
    }
}
