//
//  FilterOptionsTests.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

@testable import Popcorn
import XCTest

final class FilterOptionsTests: BaseTestCase {
    func test_getQueryParams_default_returnsEmpty() {
        // Given
        let options = FilterOptions.defaultFilter

        // When
        let params = options.getQueryParams()

        // Then
        XCTAssertTrue(params.isEmpty)
    }

    func test_getQueryParams_allFields_includesCorrectItems() {
        // Given
        let dateRange = DateRangeFilter(start: "2020-01-01", end: "2020-12-31")
        let voteRange = RangeFilter<Double>(min: 1.0, max: 5.0)
        let genre = MovieGenre(id: 99, name: "Comedy")
        let options = FilterOptions.stub(
            language: .en,
            primaryReleaseYear: 2020,
            releaseDateRange: dateRange,
            sortBy: .voteAverageDesc,
            voteRange: voteRange,
            movieGenre: genre
        )

        // When
        let params = options.getQueryParams()

        // Then
        let dict = Dictionary(uniqueKeysWithValues: params.map { ($0.name, $0.value) })
        XCTAssertEqual(dict[FilterKey.language.apiQueryName], "en")
        XCTAssertEqual(dict[FilterKey.primaryReleaseYear.apiQueryName], "2020")
        XCTAssertEqual(dict[FilterKey.releaseDateGte.apiQueryName], "2020-01-01")
        XCTAssertEqual(dict[FilterKey.releaseDateLte.apiQueryName], "2020-12-31")
        XCTAssertEqual(dict[FilterKey.sortBy.apiQueryName], SortOption.voteAverageDesc.rawValue)
        XCTAssertEqual(dict[FilterKey.voteAverageGte.apiQueryName], "1.0")
        XCTAssertEqual(dict[FilterKey.voteAverageLte.apiQueryName], "5.0")
        XCTAssertEqual(dict[FilterKey.movieGenre.apiQueryName], "99")
    }

    func test_getActiveFilters_default_returnsEmpty() {
        // Given
        let options = FilterOptions.defaultFilter

        // When
        let descriptions = options.getActiveFilters()

        // Then
        XCTAssertTrue(descriptions.isEmpty)
    }

    func test_getActiveFilters_allFields_returnsCorrectDescriptions() {
        // Given
        let dateRange = DateRangeFilter(start: "2020-01-01", end: "2020-12-31")
        let voteRange = RangeFilter<Double>(min: 2.0, max: 8.0)
        let genre = MovieGenre(id: 55, name: "Drama")
        var options = FilterOptions.defaultFilter
        options.language = .fr
        options.primaryReleaseYear = 1999
        options.releaseDateRange = dateRange
        options.sortBy = .releaseDateDesc
        options.voteRange = voteRange
        options.movieGenre = genre

        // When
        let descriptions = options.getActiveFilters()
        let values = descriptions.map { $0.value }

        // Then
        XCTAssertTrue(values.contains(SpokenLanguage.fr.englishName))
        XCTAssertTrue(values.contains("1999"))
        XCTAssertTrue(values.contains("After 2020-01-01"))
        XCTAssertTrue(values.contains("Before 2020-12-31"))
        XCTAssertTrue(values.contains(SortOption.releaseDateDesc.description))
        XCTAssertTrue(values.contains("Vote rate > 2.0"))
        XCTAssertTrue(values.contains("Vote rate < 8.0"))
        XCTAssertTrue(values.contains("Drama"))
    }

    func test_reset_filterKey_resetsToDefault() {
        // Given
        var options = FilterOptions.stub(
            language: .es,
            primaryReleaseYear: 2005,
            releaseDateRange: DateRangeFilter(start: "2000-01-01", end: "2001-01-01"),
            voteRange: RangeFilter(min: 3.0, max: 7.0),
            movieGenre: MovieGenre(id: 2, name: "Horror")
        )

        // When
        options.reset(.language)
        options.reset(.primaryReleaseYear)
        options.reset(.releaseDateGte)
        options.reset(.releaseDateLte)
        options.reset(.sortBy)
        options.reset(.voteAverageGte)
        options.reset(.voteAverageLte)
        options.reset(.movieGenre)

        // Then
        XCTAssertEqual(options.language, FilterOptions.defaultFilter.language)
        XCTAssertEqual(options.primaryReleaseYear, FilterOptions.defaultFilter.primaryReleaseYear)
        XCTAssertEqual(options.releaseDateRange?.start, FilterOptions.defaultFilter.releaseDateRange?.start)
        XCTAssertEqual(options.releaseDateRange?.end, FilterOptions.defaultFilter.releaseDateRange?.end)
        XCTAssertEqual(options.sortBy, FilterOptions.defaultFilter.sortBy)
        XCTAssertEqual(options.voteRange?.min, FilterOptions.defaultFilter.voteRange?.min)
        XCTAssertEqual(options.voteRange?.max, FilterOptions.defaultFilter.voteRange?.max)
        XCTAssertEqual(options.movieGenre, FilterOptions.defaultFilter.movieGenre)
    }
}
