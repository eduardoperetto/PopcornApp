//
//  ProductionCompanyDTO.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import shared
import Foundation

struct ProductionCompanyDTO: Codable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String
}
