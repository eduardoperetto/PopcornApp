//
//  MovieDetailsMapper.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

extension MovieDetailsResponseDTO {
    func toDomain(
        providers: Set<MovieProvider>,
        isLiked: Bool,
        isSetToWatchLater: Bool
    ) -> MovieDetails {
        MovieDetails(
            id: id,
            title: title,
            tagline: tagline,
            overview: overview,
            releaseDate: releaseDate,
            genres: Set(genres.map { $0.toDomain() }),
            runtime: runtime ?? 0,
            budget: budget,
            revenue: revenue,
            voteAverage: voteAverage,
            voteCount: voteCount,
            backdropPath: backdropPath,
            posterPath: posterPath,
            homepage: homepage,
            productionCompanies: Set(
                productionCompanies.map {
                    ProductionCompany(
                        id: $0.id,
                        name: $0.name,
                        logoPath: $0.logoPath,
                        originCountry: $0.originCountry
                    )
                }
            ),
            spokenLanguages: Set(
                spokenLanguages.compactMap { SpokenLanguage(isoCode: $0.isoCode) }
            ),
            status: status,
            movieProviders: providers,
            isLiked: isLiked,
            isSetToWatchLater: isSetToWatchLater
        )
    }
}
