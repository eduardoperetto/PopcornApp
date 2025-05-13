//
//  MoviesListView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

struct MoviesListView: View {
    @Binding var state: MovieListViewState

    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(state.movies, id: \.self) { movie in
                    MovieItemView(movie: movie)
                        .onTapGesture {
                            state.actions.onMovieTapped(movie)
                        }
                        .onAppear {
                            state.actions.onMovieCellAppeared(movie)
                        }
                }
            }
            .padding(.all, 16)

            if state.isLoadingMore {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .primaryForeground))
                    .padding()
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    let state = MovieListViewState(
        movies: [
            .init(id: 0, title: "Title", overview: "Overview", posterPath: "/6IJyv9oYKZcrTkn9jALD72QDSHh.jpg", voteAverage: 5.0),
            .init(id: 1, title: "Title", overview: "Overview", posterPath: "/6IJyv9oYKZcrTkn9jALD72QDSHh.jpg", voteAverage: 5.0),
            .init(id: 2, title: "Title", overview: "Overview", posterPath: "/6IJyv9oYKZcrTkn9jALD72QDSHh.jpg", voteAverage: 5.0),
            .init(id: 3, title: "Title", overview: "Overview", posterPath: "/6IJyv9oYKZcrTkn9jALD72QDSHh.jpg", voteAverage: 5.0)
        ],
        isLoadingMore: true
    )
    MoviesListView(state: .init(get: { state }, set: { _ in }))
}
