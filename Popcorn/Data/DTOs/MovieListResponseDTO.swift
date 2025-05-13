//
//  MovieListResponseDTO.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

struct MovieListResponseDTO: Decodable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int
}
