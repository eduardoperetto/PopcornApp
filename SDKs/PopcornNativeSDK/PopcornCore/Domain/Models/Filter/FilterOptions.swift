//
//  FilterOptions.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

public struct FilterOptions {
    public var language: SpokenLanguage?
    public var primaryReleaseYear: Int?
    public var releaseDateRange: DateRangeFilter?
    public var sortBy: SortOption = .popularityDesc
    public var voteRange: RangeFilter<Double>?
    public var movieGenre: MovieGenre?

    public init(language: SpokenLanguage? = nil, primaryReleaseYear: Int? = nil, releaseDateRange: DateRangeFilter? = nil, sortBy: SortOption = .popularityDesc, voteRange: RangeFilter<Double>? = nil, movieGenre: MovieGenre? = nil) {
        self.language = language
        self.primaryReleaseYear = primaryReleaseYear
        self.releaseDateRange = releaseDateRange
        self.sortBy = sortBy
        self.voteRange = voteRange
        self.movieGenre = movieGenre
    }
}

public extension FilterOptions {
    static let defaultFilter = FilterOptions()
}

public enum FilterKey: String, Identifiable, CaseIterable {
    case language
    case primaryReleaseYear
    case releaseDateGte
    case releaseDateLte
    case sortBy
    case voteAverageGte
    case voteAverageLte
    case movieGenre

    public var id: String { rawValue }

    var displayName: String {
        switch self {
        case .language: return "Language"
        case .primaryReleaseYear: return "Release Year"
        case .releaseDateGte: return "Release Date From"
        case .releaseDateLte: return "Release Date To"
        case .sortBy: return "Sort By"
        case .voteAverageGte: return "Min Rating"
        case .voteAverageLte: return "Max Rating"
        case .movieGenre: return "Genres"
        }
    }
}

// MARK: - FilterOptions + Reset

public extension FilterOptions {
    mutating func reset(_ filter: FilterKey) {
        switch filter {
        case .language:
            self.language = Self.defaultFilter.language
        case .primaryReleaseYear:
            self.primaryReleaseYear = Self.defaultFilter.primaryReleaseYear
        case .releaseDateGte:
            self.releaseDateRange?.start = Self.defaultFilter.releaseDateRange?.start
        case .releaseDateLte:
            self.releaseDateRange?.end = Self.defaultFilter.releaseDateRange?.end
        case .sortBy:
            self.sortBy = Self.defaultFilter.sortBy
        case .voteAverageGte:
            self.voteRange?.min = Self.defaultFilter.voteRange?.min
        case .voteAverageLte:
            self.voteRange?.max = Self.defaultFilter.voteRange?.max
        case .movieGenre:
            self.movieGenre = Self.defaultFilter.movieGenre
        }
    }
}

// MARK: - FilterOptions + Equatable

extension FilterOptions: Equatable {}
