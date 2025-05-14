//
//  MovieDetails+Stub.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation
@testable import Popcorn

extension MovieDetails {
    static func stub(
        id: Int = 1,
        title: String = "Stubbed Movie",
        tagline: String = "A great tagline",
        overview: String = "This is a stubbed movie used for testing purposes.",
        releaseDate: String = "2024-01-01",
        genres: Set<MovieGenre> = [.init(id: 1, name: "Action")],
        runtime: Int = 120,
        budget: Double = 100_000_000,
        revenue: Double = 300_000_000,
        voteAverage: Double = 8.5,
        voteCount: Int = 1200,
        backdropPath: String? = "/stubbedBackdrop.jpg",
        posterPath: String? = "/stubbedPoster.jpg",
        homepage: String? = "https://example.com/stubbed-movie",
        productionCompanies: Set<ProductionCompany> = [
            .init(id: 1, name: "Stubbed Productions", logoPath: nil, originCountry: "US")
        ],
        spokenLanguages: Set<SpokenLanguage> = [.en],
        status: String = "Released",
        movieProviders: Set<MovieProvider> = [
            .init(id: 1, name: "StubFlix", logoPath: "/StubFlix.jpg")
        ],
        isLiked: Bool = false,
        isSetToWatchLater: Bool = false
    ) -> MovieDetails {
        MovieDetails(
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
            status: status,
            movieProviders: movieProviders,
            isLiked: isLiked,
            isSetToWatchLater: isSetToWatchLater
        )
    }
}
