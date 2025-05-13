//
//  WatchLaterListView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI

struct WatchLaterListView: View {
    @ObservedObject var viewModel: WatchLaterListViewModel

    var body: some View {
        MoviesListView(state: $viewModel.state)
            .refreshable { viewModel.fetchWatchLaterMovies() }
            .onAppear { viewModel.fetchWatchLaterMovies() }
            .navigationTitle("Watch Later")
    }
}
