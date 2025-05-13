//
//  MoviesAPIRoute.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation

enum MoviesAPIRoute: APIRoute {
    case discoverMovies(filter: FilterOptions? = nil, page: Int)
    case movieDetails(id: Int)
    case movieProviders(id: Int)

    var path: String {
        switch self {
        case .discoverMovies:
            return "/3/discover/movie"
        case .movieDetails(let id):
            return "/3/movie/\(id)"
        case .movieProviders(let id):
            return "/3/movie/\(id)/watch/providers"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var baseHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }

    var queryParams: [URLQueryItem]? {
        switch self {
        case .discoverMovies(let filter, let page):
            let filterQuery = filter?.getQueryParams() ?? []
            let pageQuery = URLQueryItem(name: "page", value: page.description)
            var queryParams = filterQuery
            queryParams.append(pageQuery)
            return queryParams
        case .movieDetails:
            return nil
        case .movieProviders:
            return nil
        }
    }
}
