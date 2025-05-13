//
//  ProductionCompany.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation

struct ProductionCompany: Identifiable, Hashable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String
}
