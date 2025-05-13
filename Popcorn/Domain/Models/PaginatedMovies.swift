//
//  PaginatedMovies.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

struct PaginatedMovies {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let movies: [Movie]
}
