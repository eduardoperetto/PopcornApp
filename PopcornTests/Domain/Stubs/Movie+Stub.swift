//
//  Movie+Stub.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation
@testable import Popcorn

extension Movie {
    static func stub(
        id: Int = 1,
        title: String = "Title",
        overview: String = "Overview",
        posterPath: String? = nil,
        voteAverage: Double = 5.0
    ) -> Movie {
        Movie(id: id, title: title, overview: overview, posterPath: posterPath, voteAverage: voteAverage)
    }
}
