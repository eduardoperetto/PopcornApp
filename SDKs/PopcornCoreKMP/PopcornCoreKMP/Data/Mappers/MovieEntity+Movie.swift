//
//  MovieEntity+Movie.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 11/05/25.
//

import shared
import Foundation

extension MovieEntity {
    func toModel() -> Movie {
        Movie(
            id: Int(id),
            title: title ?? "",
            overview: overview ?? "",
            posterPath: posterPath,
            voteAverage: voteAverage
        )
    }
}
