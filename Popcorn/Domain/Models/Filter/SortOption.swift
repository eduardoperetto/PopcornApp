//
//  SortOption.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

enum SortOption: String, Equatable {
    case popularityDesc = "popularity.desc"
    case releaseDateDesc = "release_date.desc"
    case voteAverageDesc = "vote_average.desc"

    var description: String {
        switch self {
        case .popularityDesc: "Descending popularity"
        case .releaseDateDesc: "Descending release date"
        case .voteAverageDesc: "Descending vote rating"
        }
    }
}

extension SortOption: CaseIterable {
    static var allCases: [SortOption] = [.popularityDesc, .releaseDateDesc, .voteAverageDesc]
}
