//
//  FetchWatchLaterMoviesUseCaseMock.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn

final class FetchWatchLaterMoviesUseCaseMock: FetchWatchLaterMoviesUseCase {
    struct Invocation {}

    private(set) var invocations: [Invocation] = []
    private var successResult: [Movie]?
    private var errorResult: Error?
    private(set) var invocationStream: PassthroughSubject<Invocation, Never> = .init()

    init() {
        super.init(repository: DummyMovieRepository())
    }

    override func invoke() -> AnyPublisher<[Movie], Error> {
        storeInvocation()
        if let movies = successResult {
            return Just(movies)
                .setFailureType(to: Error.self)
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
        successResult = nil
        errorResult = error
    }

    func reset() {
        successResult = nil
        errorResult = nil
        invocations = []
    }

    private func storeInvocation() {
        let invocation = Invocation()
        invocations.append(invocation)
        invocationStream.send(invocation)
    }
}
