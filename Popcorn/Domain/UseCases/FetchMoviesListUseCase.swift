//
//  FetchMoviesListUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Combine
import Foundation

final class FetchMoviesListUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func invoke(filters: FilterOptions? = nil, page: Int) -> AnyPublisher<PaginatedMovies, any Error> {
        repository.fetchMovies(filtering: filters, page: page)
    }
}
