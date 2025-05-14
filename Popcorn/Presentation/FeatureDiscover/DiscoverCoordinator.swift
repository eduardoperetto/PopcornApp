//
//  MainCoordinator.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import Foundation
import SwiftUI

enum DiscoverRoute: Hashable {
    case discover
    case detail(id: Int)
}

final class DiscoverCoordinator: Coordinator<DiscoverRoute> {
    convenience init() {
        self.init(rootRoute: .discover)
    }

    override func buildView(for route: DiscoverRoute) -> AnyView {
        AppDI.container.logger.d("buildView for \(route)", tag: "DiscoverCoordinator")
        switch route {
        case .discover:
            let viewModel = DiscoverViewModel(
                coordinator: self,
                fetchMoviesListUseCase: AppDI.container.fetchMoviesUseCase
            )
            return DiscoverView(viewModel: viewModel).erased
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
