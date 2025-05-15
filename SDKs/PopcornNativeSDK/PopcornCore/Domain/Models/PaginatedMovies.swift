//
//  PaginatedMovies.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

public struct PaginatedMovies {
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int
    public let movies: [Movie]
}
