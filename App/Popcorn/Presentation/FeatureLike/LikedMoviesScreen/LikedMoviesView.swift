//
//  LikedMoviesView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI

struct LikedMoviesView: View {
    @ObservedObject var viewModel: LikedMoviesViewModel

    var body: some View {
        MoviesListView(state: $viewModel.state)
            .onAppear { viewModel.fetchLikedMovies() }
            .refreshable {  viewModel.fetchLikedMovies() }
            .navigationTitle("Liked Movies")
    }
}
