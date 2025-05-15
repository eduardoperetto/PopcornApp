//
//  URLSessionNetworkServiceTests.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn
import PopcornCore
import XCTest

final class URLSessionNetworkServiceTests: BaseTestCase {
    private var service: URLSessionNetworkService!
    private var logger: MockLogger!
    private var session: URLSession!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        logger = MockLogger()
        service = URLSessionNetworkService(session: session, logger: logger)
        cancellables = []
    }

    override func tearDown() {
        MockURLProtocol.stubError = nil
        MockURLProtocol.stubResponse = nil
        MockURLProtocol.stubResponseData = nil
        service = nil
        cancellables = nil
        super.tearDown()
    }

    func test_request_invalidURL_endpointReturnsInvalidURLError() {
        let logger = MockLogger()
        let sut = URLSessionNetworkService(logger: logger)
        let endpoint = APIEndpoint(
            baseURL: URL(string: "invalid_url")!,
            apiKey: "dummy",
            route: DummyRoute.invalid
        )

        let expectation = self.expectation(description: "Completion")
        let cancellable = sut.request(endpoint, responseType: DummyModel.self)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTAssertEqual(error, .invalidURL)
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Expected failure, got value")
                }
            )

        wait(for: [expectation], timeout: 1.0)
        _ = cancellable
    }


    func test_request_success_decodesObject() {
        // Given
        let json = "{ \"foo\": \"bar\" }".data(using: .utf8)!
        MockURLProtocol.stubResponseData = json
        MockURLProtocol.stubResponse = HTTPURLResponse(
            url: URL(string: "https://test")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let endpoint = APIEndpoint(
            baseURL: URL(string: "https://api.test.com")!,
            apiKey: "key",
            route: DummyRoute(path: "/d", method: .get, baseHeaders: [:], queryParams: nil)
        )
        let exp = expectation(description: "decode success")

        // When
        service.request(endpoint, responseType: DummyDecodable.self)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Expected success")
                }
            } receiveValue: { value in
                // Then
                XCTAssertEqual(value, DummyDecodable(foo: "bar"))
                exp.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_request_serverError_returnsServerError() {
        // Given
        let data = "{}".data(using: .utf8)!
        MockURLProtocol.stubResponseData = data
        MockURLProtocol.stubResponse = HTTPURLResponse(
            url: URL(string: "https://test")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        let endpoint = APIEndpoint(
            baseURL: URL(string: "https://api.test.com")!,
            apiKey: "key",
            route: DummyRoute(path: "/err", method: .get, baseHeaders: [:], queryParams: nil)
        )
        let exp = expectation(description: "server error")

        // When
        service.request(endpoint, responseType: DummyDecodable.self)
            .sink { completion in
                // Then
                if case let .failure(error) = completion {
                    if case let .serverError(code) = error {
                        XCTAssertEqual(code, 500)
                        exp.fulfill()
                    } else {
                        XCTFail("Expected serverError")
                    }
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_request_decodingError_returnsDecodingFailed() {
        // Given
        let invalidJson = "{ \"foo\": 123 }".data(using: .utf8)!
        MockURLProtocol.stubResponseData = invalidJson
        MockURLProtocol.stubResponse = HTTPURLResponse(
            url: URL(string: "https://test")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let endpoint = APIEndpoint(
            baseURL: URL(string: "https://api.test.com")!,
            apiKey: "key",
            route: DummyRoute(path: "/bad", method: .get, baseHeaders: [:], queryParams: nil)
        )
        let exp = expectation(description: "decoding error")

        // When
        service.request(endpoint, responseType: DummyDecodable.self)
            .sink { completion in
                // Then
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .decodingFailed)
                    exp.fulfill()
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }
}

struct DummyModel: Decodable, Equatable {
    let id: Int
    let name: String
}
