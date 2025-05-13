//
//  APIEndpoint.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation

struct APIEndpoint {
    let baseURL: URL
    let apiKey: String
    let route: APIRoute
}

extension APIEndpoint {
    var url: URL? {
        guard let url = URL(string: route.path, relativeTo: baseURL) else { return nil }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = route.queryParams
        return urlComponents.url
    }

    var request: URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        request.allHTTPHeaderFields = route.baseHeaders
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }
}
