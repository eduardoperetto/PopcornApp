//
//  DiscoverView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import SwiftUI
import UIKit

struct DiscoverView: View {
    @StateObject var viewModel: DiscoverViewModel

    var body: some View {
        Group {
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                MoviesListView(state: $viewModel.state)
//                    .searchable(text: $viewModel.state.titleSearchQuery)
//                    .onChange(of: viewModel.state.titleSearchQuery) { viewModel.searchAndUpdateLoadedMovies() }
                    .catchingErrorState(viewModel.state.error)
                    .refreshable { viewModel.fetchMovies() }
                    .filterable(viewModel: viewModel)
            }
        }
        .navigationTitle("Discover")
        .onAppear { viewModel.fetchMovies() }
    }
}

#Preview {
    let useCase = AppDI.container.fetchMoviesUseCase
    let viewModel = DiscoverViewModel(coordinator: DiscoverCoordinator(), fetchMoviesListUseCase: useCase)
    DiscoverView(viewModel: viewModel)
}
