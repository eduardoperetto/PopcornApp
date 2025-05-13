//
//  URLSessionNetworkService.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Combine
import Foundation
final class URLSessionNetworkService: NetworkService {
    private let session: URLSession
    private let logger: LoggerProtocol
    private static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(
        session: URLSession = .shared,
        logger: LoggerProtocol
    ) {
        self.session = session
        self.logger = logger
    }

    func request<T: Decodable>(
        _ endpoint: APIEndpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = endpoint.request else {
            logger.e("Invalid URL for endpoint: \(endpoint.route.path)", tag: "NetworkService")
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        let requestId = "\(endpoint.route.path) (\(UUID().uuidString))"

        logger.d("""
        🚀 Starting request \(requestId)
        URL: \(urlRequest.url?.absoluteString ?? "N/A")
        Method: \(urlRequest.httpMethod ?? "N/A")
        Headers: \(urlRequest.allHTTPHeaderFields?.keys.joined(separator: ", ") ?? "N/A")
        Body: \(urlRequest.httpBody?.prettyPrintedString ?? "Empty")
        """, tag: "NetworkService")

        let startTime = Date()

        return session.dataTaskPublisher(for: urlRequest)
            .handleEvents(receiveSubscription: { _ in
                self.logger.d("⬆️ Request \(requestId) sent to server", tag: "NetworkService")
            }, receiveOutput: { data, response in
                let duration = String(format: "%.2fs", Date().timeIntervalSince(startTime))
                if let httpResponse = response as? HTTPURLResponse {
                    self.logger.d("""
                    ⬇️ Received response \(requestId)
                    Status: \(httpResponse.statusCode)
                    Duration: \(duration)
                    Headers: \(httpResponse.allHeaderFields.keys)
                    Body Preview: \(data.prefix(300).prettyPrintedString ?? "Empty")
                    """, tag: "NetworkService")
                }
            }, receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.logger.d("""
                    ‼️ Request \(requestId) failed
                    Error: \(error.localizedDescription)
                    """, tag: "NetworkService")
                }
            })
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.logger.d("Invalid response type for request \(requestId)", tag: "NetworkService")
                    throw NetworkError.invalidResponse
                }

                self.logger.d("Request \(requestId) received HTTP \(httpResponse.statusCode)", tag: "NetworkService")

                guard (200 ..< 300).contains(httpResponse.statusCode) else {
                    self.logger.e("""
                    Server error for request \(requestId)
                    Status Code: \(httpResponse.statusCode)
                    Response Body: \(data.prettyPrintedString ?? "Empty")
                    """, tag: "NetworkService")
                    throw NetworkError.serverError(httpResponse.statusCode)
                }

                return data
            }
            .decode(type: T.self, decoder: Self.jsonDecoder)
            .mapError { error -> NetworkError in
                let networkError = NetworkError.mapError(error)
                self.logger.e("""
                Decoding failed for request \(requestId)
                Error: \(error)
                """, tag: "NetworkService")
                return networkError
            }
            .handleEvents(receiveOutput: { _ in
                self.logger.d("""
                ✅ Successfully decoded response for request \(requestId)
                Decoded Type: \(T.self)
                """, tag: "NetworkService")
            })
            .eraseToAnyPublisher()
    }
}

private extension Data {
    var prettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self),
              let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}
