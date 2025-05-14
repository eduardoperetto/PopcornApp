//
//  LikeCoordinator.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation
import SwiftUI

enum LikeRoute: Hashable {
    case likedMovies
    case detail(id: Int)
}

final class LikeCoordinator: Coordinator<LikeRoute> {
    convenience init() {
        self.init(rootRoute: .likedMovies)
    }

    override func buildView(for route: LikeRoute) -> AnyView {
        switch route {
        case .likedMovies:
            let viewModel = LikedMoviesViewModel(
                coordinator: self,
                fetchLikedMoviesUseCase: AppDI.container.fetchLikedMoviesUseCase
            )
            return LikedMoviesView(viewModel: viewModel).erased
        case let .detail(id):
            let viewModel = MovieDetailsViewModel(
                movieId: id,
                fetchMovieDetailsUseCase: AppDI.container.fetchMovieDetailsUseCase,
                setMovieLikedUseCase: AppDI.container.setMovieLikedUseCase,
                setMovieWatchLaterUseCase: AppDI.container.setMovieWatchLaterUseCase
            )
            return MovieDetailsView(viewModel: viewModel).erased
        }
    }
}
