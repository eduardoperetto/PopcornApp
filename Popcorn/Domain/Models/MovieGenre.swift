//
//  MovieGenre.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

struct MovieGenre: SelectionPickable {
    let id: Int
    let name: String
}

extension MovieGenre: CaseIterable {
    static var allCases: [MovieGenre] {
        return [
            MovieGenre(id: 28, name: "Action"),
            MovieGenre(id: 12, name: "Adventure"),
            MovieGenre(id: 16, name: "Animation"),
            MovieGenre(id: 35, name: "Comedy"),
            MovieGenre(id: 80, name: "Crime"),
            MovieGenre(id: 99, name: "Documentary"),
            MovieGenre(id: 18, name: "Drama"),
            MovieGenre(id: 10751, name: "Family"),
            MovieGenre(id: 14, name: "Fantasy"),
            MovieGenre(id: 36, name: "History"),
            MovieGenre(id: 27, name: "Horror"),
            MovieGenre(id: 10402, name: "Music"),
            MovieGenre(id: 9648, name: "Mystery"),
            MovieGenre(id: 10749, name: "Romance"),
            MovieGenre(id: 878, name: "Science Fiction"),
            MovieGenre(id: 10770, name: "TV Movie"),
            MovieGenre(id: 53, name: "Thriller"),
            MovieGenre(id: 10752, name: "War"),
            MovieGenre(id: 37, name: "Western")
        ]
    }
}

// MARK: - MovieGenre + Equatable

extension MovieGenre: Equatable {}
