//
//  MovieDetailsResponseDTO.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

struct MovieDetailsResponseDTO: Codable {
    let id: Int
    let title: String
    let tagline: String
    let overview: String
    let releaseDate: String
    let genres: [GenreDTO]
    let runtime: Int?
    let budget: Double
    let revenue: Double
    let voteAverage: Double
    let voteCount: Int
    let backdropPath: String?
    let posterPath: String?
    let homepage: String?
    let productionCompanies: [ProductionCompanyDTO]
    let spokenLanguages: [SpokenLanguageDTO]
    let status: String
}
