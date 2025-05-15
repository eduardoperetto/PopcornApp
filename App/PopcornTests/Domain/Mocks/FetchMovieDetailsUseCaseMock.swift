//
//  FetchMovieDetailsUseCaseMock.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn

final class FetchMovieDetailsUseCaseMock: FetchMovieDetailsUseCase {
    struct Invocation {
        let movieId: Int
    }

    private(set) var invocations: [Invocation] = []
    private var successResult: MovieDetails?
    private var errorResult: Error?
    private(set) var invocationStream: PassthroughSubject<Invocation, Never> = .init()

    init() {
        super.init(repository: DummyMovieRepository())
    }

    override func invoke(movieId: Int) -> AnyPublisher<MovieDetails, Error> {
        storeInvocation(movieId)
        if let movieDetails = successResult {
            return Just(movieDetails)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        if let errorResult {
            return Fail(error: errorResult)
                .eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }

    func setResult(_ movieDetails: MovieDetails) {
        successResult = movieDetails
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

    private func storeInvocation(_ movieId: Int) {
        let invocation = Invocation(movieId: movieId)
        invocations.append(invocation)
        invocationStream.send(invocation)
    }
}
