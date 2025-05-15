//
//  FetchMoviesListUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Combine
import Foundation

public class FetchMoviesListUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func invoke(filters: FilterOptions? = nil, page: Int) -> AnyPublisher<PaginatedMovies, any Error> {
        repository.fetchMovies(filtering: filters, page: page)
    }
}
