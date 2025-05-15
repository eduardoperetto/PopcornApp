//
//  FilerableViewModelTests.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn
import XCTest

final class FilterableViewModelTests: BaseTestCase {
    private var sut: TestFilterableViewModel!

    override func setUp() {
        super.setUp()
        sut = TestFilterableViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_openFilterSheet_setsPresentFilterSheetTrue() {
        // Given
        // When
        sut.openFilterSheet()
        // Then
        XCTAssertTrue(sut.presentFilterSheet)
    }

    func test_closeFilterSheet_setsPresentFilterSheetFalse() {
        // Given
        sut.presentFilterSheet = true
        // When
        sut.closeFilterSheet()
        // Then
        XCTAssertFalse(sut.presentFilterSheet)
    }

    func test_applyFilters_updatesAppliedFilters_andClosesSheet_andTriggersOnFiltersApplied() {
        // Given
        let filters = FilterOptions.stub(movieGenre: .init(id: 3, name: "Thriller"))
        sut.presentFilterSheet = true

        // When
        sut.applyFilters(filters)

        // Then
        XCTAssertEqual(sut.appliedFilters, filters)
        XCTAssertFalse(sut.presentFilterSheet)
        XCTAssertEqual(sut.appliedFiltersRecords, [filters])
    }

    func test_resetFilter_resetsSpecificFilter_andTriggersOnFiltersApplied() {
        // Given
        let filters = FilterOptions.stub(language: .de, primaryReleaseYear: 2022)
        sut.appliedFilters = filters
        sut.appliedFiltersRecords = []

        // When
        sut.resetFilter(.primaryReleaseYear)

        // Then
        XCTAssertEqual(sut.appliedFilters.primaryReleaseYear, FilterOptions.defaultFilter.primaryReleaseYear)
        XCTAssertEqual(sut.appliedFiltersRecords.count, 1)
    }
}

// MARK: - Testable Subclass

private final class TestFilterableViewModel: FilterableViewModel {
    var appliedFiltersRecords: [FilterOptions] = []

    override func onFiltersApplied(_ filters: FilterOptions) {
        appliedFiltersRecords.append(filters)
    }
}
