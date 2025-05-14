//
//  NetworkError.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed
    case decodingFailed
    case invalidResponse
    case serverError(Int)
    case unknownError(String)
}

extension NetworkError {
    static func mapError(_ error: Error) -> NetworkError {
        if let networkError = error as? NetworkError {
            return networkError
        }

        if error is DecodingError {
            return .decodingFailed
        }

        if let urlError = error as? URLError {
            switch urlError.code {
            case .badURL:
                return .invalidURL
            case .notConnectedToInternet, .timedOut, .networkConnectionLost, .cannotFindHost, .cannotConnectToHost:
                return .requestFailed
            default:
                return .unknownError(urlError.localizedDescription)
            }
        }

        return .unknownError(error.localizedDescription)
    }
}
