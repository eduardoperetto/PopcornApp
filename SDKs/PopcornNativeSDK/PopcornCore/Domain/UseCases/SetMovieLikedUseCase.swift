//
//  ToggleMovieLikeUseCase.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Combine
import Foundation

public class SetMovieLikedUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func invoke(_ movie: Movie, _ isLiked: Bool) -> AnyPublisher<Void, Error> {
        if isLiked {
            return repository.storeLikedMovie(movie)
        } else {
            return repository.removeLikedMovie(movie)
        }
    }
}
