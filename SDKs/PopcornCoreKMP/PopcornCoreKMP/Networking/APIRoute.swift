//
//  APIRoute.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import shared
import Foundation

public protocol APIRoute {
    var path: String { get }
    var method: HTTPMethod { get }
    var baseHeaders: [String: String] { get }
    var queryParams: [URLQueryItem]? { get }
}
