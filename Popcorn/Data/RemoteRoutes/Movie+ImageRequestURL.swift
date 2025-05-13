//
//  Movie+ImageRequestURL.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import Foundation

extension URL {
    static func buildImageURL(for path: String?, quality: ImageQuality) -> URL? {
        guard let path else { return nil }
        let baseUrl = AppDIContainer.shared.environment.imageBaseUrl
        return URL(string: "/t/p/\(quality.rawValue)\(path)", relativeTo: baseUrl)
    }
}
