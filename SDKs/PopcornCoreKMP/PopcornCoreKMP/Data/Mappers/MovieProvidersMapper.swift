//
//  MovieProvidersMapper.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import shared
import Foundation

extension MovieProvidersResponseDTO {
    func toDomain() -> Set<MovieProvider> {
        guard let usProviders = results["US"] else { return [] }
        var providers = usProviders.flatrate ?? []
        providers.append(contentsOf: usProviders.buy ?? [])
        let providersList = providers.map {
            MovieProvider(id: $0.providerId, name: $0.providerName, logoPath: $0.logoPath)
        }
        return Set(providersList)
    }
}
