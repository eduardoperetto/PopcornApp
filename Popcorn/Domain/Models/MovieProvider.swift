//
//  MovieProvider.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

struct MovieProvider: Hashable, Equatable, Identifiable {
    let id: Int
    let name: String
    let logoPath: String
}
