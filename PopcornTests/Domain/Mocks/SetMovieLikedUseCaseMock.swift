//
//  SetMovieLikedUseCaseMock.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
@testable import Popcorn

final class SetMovieLikedUseCaseMock: SetMovieLikedUseCase {
    struct Invocation {
        let movie: Movie
        let isLiked: Bool
    }

    private(set) var invocations: [Invocation] = []
    private var errorResult: Error?
    private var shouldSucceed: Bool = true
    private(set) var invocationStream: PassthroughSubject<Invocation, Never> = .init()

    init() {
        super.init(repository: DummyMovieRepository())
    }

    override func invoke(_ movie: Movie, _ isLiked: Bool) -> AnyPublisher<Void, Error> {
        storeInvocation(movie, isLiked)
        if shouldSucceed {
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        if let errorResult {
            return Fail(error: errorResult)
                .eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }

    func setResult(success: Bool) {
        shouldSucceed = success
        errorResult = nil
    }

    func setResult(_ error: Error) {
        shouldSucceed = false
        errorResult = error
    }

    func reset() {
        invocations = []
        errorResult = nil
        shouldSucceed = true
    }

    private func storeInvocation(_ movie: Movie, _ isLiked: Bool) {
        let invocation = Invocation(movie: movie, isLiked: isLiked)
        invocations.append(invocation)
        invocationStream.send(invocation)
    }
}
