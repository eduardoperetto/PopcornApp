//
//  MockNetworkService.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
import Foundation
@testable import Popcorn

class MockNetworkService: NetworkService {
    var responses: [APIEndpoint: Result<Data, NetworkError>] = [:]
    var requestedEndpoints: [APIEndpoint] = []

    func request<T: Decodable>(
        _ endpoint: APIEndpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        requestedEndpoints.append(endpoint)
        if let result = responses[endpoint] {
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return Just(decoded)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: .decodingFailed)
                        .eraseToAnyPublisher()
                }
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        return Empty().setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
}
