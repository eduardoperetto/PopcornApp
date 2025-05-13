//
//  MovieDetail+Movie.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import Foundation

extension MovieDetails {
    func toMovie() -> Movie {
        .init(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            voteAverage: voteAverage
        )
    }
}
