//
//  MovieProvidersResponseDTO.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

struct MovieProvidersResponseDTO: Codable {
    let results: [String: ProvidersListDTO]

    struct ProvidersListDTO: Codable {
        let flatrate: [MovieProviderDTO]?
        let buy: [MovieProviderDTO]?
    }
}
