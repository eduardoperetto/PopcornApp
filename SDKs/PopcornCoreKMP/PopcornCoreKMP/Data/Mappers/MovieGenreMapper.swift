//
//  MovieGenreMapper.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import shared
import Foundation

extension GenreDTO {
    func toDomain() -> MovieGenre {
        .init(
            id: id,
            name: name
        )
    }
}
