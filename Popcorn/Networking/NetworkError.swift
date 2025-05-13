//
//  NetworkError.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case invalidResponse
    case serverError(Int)
    case unknownError(String)
}

extension NetworkError {
    static func mapError(_ error: Error) -> NetworkError {
        switch error {
        case URLError.badURL:
            return .invalidURL
        case URLError.notConnectedToInternet:
            return .requestFailed
        default:
            return .unknownError(error.localizedDescription)
        }
    }
}
