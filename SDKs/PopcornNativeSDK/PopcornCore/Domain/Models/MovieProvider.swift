//
//  MovieProvider.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

public struct MovieProvider: Hashable, Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let logoPath: String

    public init(id: Int, name: String, logoPath: String) {
        self.id = id
        self.name = name
        self.logoPath = logoPath
    }
}
