//
//  DummyRoute.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation
@testable import Popcorn

struct DummyRoute: APIRoute {
    let path: String
    let method: HTTPMethod
    let baseHeaders: [String: String]
    let queryParams: [URLQueryItem]?
}

extension DummyRoute {
    static let invalid: DummyRoute = .init(
        path: "http://%",
        method: .get,
        baseHeaders: [:],
        queryParams: nil
    )
}
