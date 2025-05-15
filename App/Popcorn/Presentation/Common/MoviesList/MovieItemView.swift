//
//  MovieItemView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI
import PopcornCore

struct MovieItemView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            MoviePosterImageView(movie: movie)
                .background(Color.background)
                .cornerRadius(8)

            Text(movie.title)
                .font(.subheadline)
                .foregroundColor(.darkForeground)
                .lineLimit(1)

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundColor(.primaryForeground)
                Text(String(format: "%.1f", movie.voteAverage))
                    .font(.caption2)
                    .foregroundColor(.darkForeground)
            }
        }
    }
}
#Preview {
    MovieItemView(movie: .init(id: 0, title: "Title", overview: "Overview", posterPath: "/6IJyv9oYKZcrTkn9jALD72QDSHh.jpg", voteAverage: 5.0))
}
