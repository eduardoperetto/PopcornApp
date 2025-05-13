//
//  MovieDetails.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation

struct MovieDetails {
    let id: Int
    let title: String
    let tagline: String
    let overview: String
    let releaseDate: String
    let genres: Set<MovieGenre>
    let runtime: Int
    let budget: Double
    let revenue: Double
    let voteAverage: Double
    let voteCount: Int
    let backdropPath: String?
    let posterPath: String?
    let homepage: String?
    let productionCompanies: Set<ProductionCompany>
    let spokenLanguages: Set<SpokenLanguage>
    let status: String
    let movieProviders: Set<MovieProvider>
    var isLiked: Bool
    var isSetToWatchLater: Bool
}
