//
//  SpokenLanguageDTO.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import shared
import Foundation

struct SpokenLanguageDTO: Codable {
    let englishName: String
    let name: String
    let isoCode: String

    enum CodingKeys: String, CodingKey {
        case englishName = "englishName"
        case name = "name"
        case isoCode = "iso6391"
    }
}
