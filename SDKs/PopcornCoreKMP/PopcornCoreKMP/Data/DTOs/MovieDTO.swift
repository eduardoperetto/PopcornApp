//
//  MovieDTO.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import shared
import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let originalLanguage: String?
    let adult: Bool
    let video: Bool
}
