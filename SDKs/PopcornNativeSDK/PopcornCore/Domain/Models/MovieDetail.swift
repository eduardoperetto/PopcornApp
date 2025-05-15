//
//  MovieDetails.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation

public struct MovieDetails {
    public let id: Int
    public let title: String
    public let tagline: String
    public let overview: String
    public let releaseDate: String
    public let genres: Set<MovieGenre>
    public let runtime: Int
    public let budget: Double
    public let revenue: Double
    public let voteAverage: Double
    public let voteCount: Int
    public let backdropPath: String?
    public let posterPath: String?
    public let homepage: String?
    public let productionCompanies: Set<ProductionCompany>
    public let spokenLanguages: Set<SpokenLanguage>
    public let status: String
    public let movieProviders: Set<MovieProvider>
    public var isLiked: Bool
    public var isSetToWatchLater: Bool

    public init(id: Int, title: String, tagline: String, overview: String, releaseDate: String, genres: Set<MovieGenre>, runtime: Int, budget: Double, revenue: Double, voteAverage: Double, voteCount: Int, backdropPath: String?, posterPath: String?, homepage: String?, productionCompanies: Set<ProductionCompany>, spokenLanguages: Set<SpokenLanguage>, status: String, movieProviders: Set<MovieProvider>, isLiked: Bool, isSetToWatchLater: Bool) {
        self.id = id
        self.title = title
        self.tagline = tagline
        self.overview = overview
        self.releaseDate = releaseDate
        self.genres = genres
        self.runtime = runtime
        self.budget = budget
        self.revenue = revenue
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.homepage = homepage
        self.productionCompanies = productionCompanies
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.movieProviders = movieProviders
        self.isLiked = isLiked
        self.isSetToWatchLater = isSetToWatchLater
    }
}
