//
//  ToggleMovieLikeUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Combine
import Foundation

class SetMovieLikedUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func invoke(_ movie: Movie, _ isLiked: Bool) -> AnyPublisher<Void, Error> {
        if isLiked {
            return repository.storeLikedMovie(movie)
        } else {
            return repository.removeLikedMovie(movie)
        }
    }
}
