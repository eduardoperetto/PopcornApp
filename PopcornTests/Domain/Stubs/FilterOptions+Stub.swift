//
//  FilterOptions+Stub.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

@testable import Popcorn

extension FilterOptions {
    static func stub(
        language: SpokenLanguage? = nil,
        primaryReleaseYear: Int? = nil,
        releaseDateRange: DateRangeFilter? = nil,
        sortBy: SortOption = .popularityDesc,
        voteRange: RangeFilter<Double>? = nil,
        movieGenre: MovieGenre? = nil
    ) -> Self {
        .init(
            language: language,
            primaryReleaseYear: primaryReleaseYear,
            releaseDateRange: releaseDateRange,
            sortBy: sortBy,
            voteRange: voteRange,
            movieGenre: movieGenre
        )
    }
}
