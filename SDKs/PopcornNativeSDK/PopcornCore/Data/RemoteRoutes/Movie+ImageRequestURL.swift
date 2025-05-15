//
//  Movie+ImageRequestURL.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import Foundation

public extension URL {
    static func buildImageURL(
        for path: String?,
        quality: ImageQuality,
        baseUrl: URL?
    ) -> URL? {
        guard let path else { return nil }
        return URL(string: "/t/p/\(quality.rawValue)\(path)", relativeTo: baseUrl)
    }
}
