//
//  FilterDescription.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

public struct FilterDescription: Identifiable {
    public let keyType: FilterKey
    public let value: String
    public var id: String { self.keyType.id }
}

// MARK: - FilterOptions + FilterDescription

public extension FilterOptions {
    func getActiveFilters() -> [FilterDescription] {
        var filters = [FilterDescription]()

        if let language {
            filters.append(FilterDescription(
                keyType: .language,
                value: language.englishName
            ))
        }

        if let primaryReleaseYear {
            filters.append(FilterDescription(
                keyType: .primaryReleaseYear,
                value: String(primaryReleaseYear)
            ))
        }

        if let releaseDateRange {
            if let start = releaseDateRange.start {
                filters.append(FilterDescription(
                    keyType: .releaseDateGte,
                    value: "After \(start)"
                ))
            }
            if let end = releaseDateRange.end {
                filters.append(FilterDescription(
                    keyType: .releaseDateLte,
                    value: "Before \(end)"
                ))
            }
        }

        if self.sortBy != .popularityDesc {
            filters.append(FilterDescription(
                keyType: .sortBy,
                value: self.sortBy.description
            ))
        }

        if let voteRange {
            if let voteMin = voteRange.min {
                filters.append(FilterDescription(
                    keyType: .voteAverageGte,
                    value: "Vote rate > \(voteMin)"
                ))
            }
            if let voteMax = voteRange.max {
                filters.append(FilterDescription(
                    keyType: .voteAverageLte,
                    value: "Vote rate < \(voteMax)"
                ))
            }
        }

        if let movieGenre {
            filters.append(FilterDescription(
                keyType: .movieGenre,
                value: movieGenre.name
            ))
        }

        return filters
    }
}
