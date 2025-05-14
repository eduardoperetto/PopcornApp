//
//  PaginatedResponse+Stub.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

@testable import Popcorn

extension PaginatedMovies {
    static func stub(
        page: Int = 1,
        totalPages: Int = 1,
        totalResults: Int = 1,
        movies: [Movie] = [.stub()]
    ) -> PaginatedMovies {
        PaginatedMovies(page: page, totalPages: totalPages, totalResults: totalResults, movies: movies)
    }
}
