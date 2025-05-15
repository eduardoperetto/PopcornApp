//
//  WatchLaterCoordinator.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation
import SwiftUI

enum WatchLaterRoute: Hashable {
    case watchLaterList
    case detail(id: Int)
}

final class WatchLaterCoordinator: Coordinator<WatchLaterRoute> {
    convenience init() {
        self.init(rootRoute: .watchLaterList)
    }

    override func buildView(for route: WatchLaterRoute) -> AnyView {
        switch route {
        case .watchLaterList:
            let viewModel = WatchLaterListViewModel(
                coordinator: self,
                fetchWatchLaterMoviesUseCase: AppDI.container.fetchWatchLaterMoviesUseCase
            )
            return WatchLaterListView(viewModel: viewModel).erased
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
