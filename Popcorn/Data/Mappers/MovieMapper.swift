//
//  MovieMapper.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

extension MovieDTO {
    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            voteAverage: voteAverage
        )
    }
}
