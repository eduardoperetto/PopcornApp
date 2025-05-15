//
//  MoviePosterImageView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI
import PopcornCore

struct MoviePosterImageView: View {
    let movie: Movie

    private let aspectRatio: CGFloat = 2 / 3

    var body: some View {
        PopcornAsyncImageView(
            imageUrl: .buildImageURL(for: movie.posterPath, quality: .medium, baseUrl: AppDI.container.environment.imageBaseUrl),
            aspectRatio: aspectRatio
        )
    }
}

#Preview {
    MoviePosterImageView(movie: .init(id: 0, title: "Title", overview: "Overview", posterPath: "/6IJyv9oYKZcrTkn9jALD72QDSHh.jpg", voteAverage: 5.0))
}
