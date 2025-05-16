//
//  MovieListMapper.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import shared
import Foundation

extension MovieListResponseDTO {
    func toDomain() -> PaginatedMovies {
        PaginatedMovies(
            page: page,
            totalPages: totalPages,
            totalResults: totalResults,
            movies: results.map { $0.toDomain() }
        )
    }
}
