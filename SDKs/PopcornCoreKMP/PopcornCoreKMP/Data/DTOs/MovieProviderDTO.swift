//
//  MovieProviderDTO.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import shared
struct MovieProviderDTO: Codable {
    let providerId: Int
    let providerName: String
    let logoPath: String
}
