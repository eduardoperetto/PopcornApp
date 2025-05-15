//
//  FetchLikedMoviesUseCaseMock.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
import Foundation
@testable import Popcorn
import PopcornCore

final class FetchLikedMoviesUseCaseMock: FetchLikedMoviesUseCase {
    struct Invocation {}
    private(set) var invocations: [Invocation] = []
    private var errorResult: Error?
    private var successResult: [Movie]?
    private(set) var invocationStream: PassthroughSubject<Invocation, Never> = .init()

    init() {
        super.init(repository: DummyMovieRepository())
    }

    override func invoke() -> AnyPublisher<[Movie], any Error> {
        storeInvocation()
        if let movies = successResult {
            return Just(movies)
                .mapError { _ in NetworkError.invalidResponse }
                .eraseToAnyPublisher()
        }
        if let error = errorResult {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }

    func setResult(_ movies: [Movie]) {
        successResult = movies
        errorResult = nil
    }

    func setResult(_ error: Error) {
        errorResult = error
        successResult = nil
    }

    func reset() {
        errorResult = nil
        successResult = nil
        invocations = []
    }

    private func storeInvocation() {
        let invocation = Invocation()
        invocations.append(invocation)
        invocationStream.send(invocation)
    }
}
