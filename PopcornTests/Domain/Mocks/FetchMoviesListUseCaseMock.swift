//
//  FetchMoviesListUseCaseMock.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Combine
import Foundation
@testable import Popcorn

final class FetchMoviesListUseCaseMock: FetchMoviesListUseCase {
    struct Invocation {
        let filters: FilterOptions?
        let page: Int
    }

    private(set) var invocations: [Invocation] = []
    private var errorResult: Error?
    private var successResult: PaginatedMovies?
    private(set) var invocationStream: PassthroughSubject<Invocation, Never> = .init()

    init() {
        super.init(repository: DummyMovieRepository())
    }

    override func invoke(filters: FilterOptions? = nil, page: Int) -> AnyPublisher<PaginatedMovies, Error> {
        storeInvocation(filters, page)
        if let successResult {
            return Just(successResult)
                .mapError { _ in NetworkError.invalidResponse }
                .eraseToAnyPublisher()
        }
        if let errorResult {
            return Fail(error: errorResult)
                .eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }

    func setResult(_ error: Error) {
        errorResult = error
        successResult = nil
    }

    func setResult(_ value: PaginatedMovies) {
        errorResult = nil
        successResult = value
    }

    func reset() {
        errorResult = nil
        successResult = nil
        invocations = []
    }

    private func storeInvocation(_ filters: FilterOptions?, _ page: Int) {
        let invocation = Invocation(filters: filters, page: page)
        invocations.append(invocation)
        invocationStream.send(invocation)
    }
}
