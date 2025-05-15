//
//  FilterOptions+QueryParams.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation

extension FilterOptions {
    func getQueryParams() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        // Language
        if language != Self.defaultFilter.language {
            queryItems.append(URLQueryItem(
                name: FilterKey.language.apiQueryName,
                value: language?.rawValue
            ))
        }

        // Release Year
        if let primaryReleaseYear {
            queryItems.append(URLQueryItem(
                name: FilterKey.primaryReleaseYear.apiQueryName,
                value: String(primaryReleaseYear)
            ))
        }

        // Date Range
        if let releaseDateRange {
            queryItems.append(URLQueryItem(
                name: FilterKey.releaseDateGte.apiQueryName,
                value: releaseDateRange.start
            ))
            queryItems.append(URLQueryItem(
                name: FilterKey.releaseDateLte.apiQueryName,
                value: releaseDateRange.end
            ))
        }

        // Sorting
        if sortBy != .popularityDesc {
            queryItems.append(URLQueryItem(
                name: FilterKey.sortBy.apiQueryName,
                value: sortBy.rawValue
            ))
        }

        // Vote Range
        if let voteRange {
            if let voteMin = voteRange.min {
                queryItems.append(URLQueryItem(
                    name: FilterKey.voteAverageGte.apiQueryName,
                    value: String(voteMin)
                ))
            }
            if let voteMax = voteRange.max {
                queryItems.append(URLQueryItem(
                    name: FilterKey.voteAverageLte.apiQueryName,
                    value: String(voteMax)
                ))
            }
        }

        // Genre
        if let movieGenre {
            queryItems.append(URLQueryItem(
                name: FilterKey.movieGenre.apiQueryName,
                value: movieGenre.id.description
            ))
        }

        return queryItems
    }
}

extension FilterKey {
    var apiQueryName: String {
        switch self {
        case .language: return "language"
        case .primaryReleaseYear: return "primary_release_year"
        case .releaseDateGte: return "release_date.gte"
        case .releaseDateLte: return "release_date.lte"
        case .sortBy: return "sort_by"
        case .voteAverageGte: return "vote_average.gte"
        case .voteAverageLte: return "vote_average.lte"
        case .movieGenre: return "with_genres"
        }
    }
}
