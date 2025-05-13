//
//  Environment.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation

struct PopcornEnvironment {
    let apiKey: String
    let baseUrl: URL
    let imageBaseUrl: URL
}

extension PopcornEnvironment {
    init() {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "baseUrl") as? String
        let imageBaseUrl = Bundle.main.object(forInfoDictionaryKey: "imageBaseUrl") as? String

        guard let apiKey, let baseUrl, let imageBaseUrl else {
            fatalError("Missing environment variables")
        }
        guard let convertedBaseUrl = URL(string: baseUrl) else {
            fatalError("Invalid Base URL: \(baseUrl)")
        }
        guard let convertedImageBaseUrl = URL(string: imageBaseUrl) else {
            fatalError("Invalid Image Base URL: \(imageBaseUrl)")
        }
        self.apiKey = apiKey
        self.baseUrl = convertedBaseUrl
        self.imageBaseUrl = convertedImageBaseUrl
    }
}
