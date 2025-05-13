//
//  NetworkService.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Combine

protocol NetworkService {
    func request<T: Decodable>(
        _ endpoint: APIEndpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>
}
