//
//  Environment+Mock.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
import Foundation
@testable import Popcorn

// MARK: - Mock PopcornEnvironment

extension PopcornEnvironment {
    static let mock = PopcornEnvironment(
        apiKey: "test-api-key",
        baseUrl: URL(string: "https://api.test.com")!,
        imageBaseUrl: URL(string: "https://images.test.com")!
    )
}
