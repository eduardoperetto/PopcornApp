//
//  GenreSelectionView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import SwiftUI

struct GenreSelectionView: View {
    @Binding var selectedGenres: [MovieGenre]?
    let allGenres = MovieGenre.allCases

    var body: some View {
        NavigationView {
            List {
                ForEach(allGenres) { genre in
                    Button(action: { toggleGenre(genre) }) {
                        HStack {
                            Text(genre.name)
                            Spacer()
                            if (selectedGenres ?? []).contains(where: { $0.id == genre.id }) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Genres")
            .navigationBarItems(trailing: Button("Done") {})
        }
    }

    private func toggleGenre(_ genre: MovieGenre) {
        if selectedGenres == nil {
            selectedGenres = []
        }
        if let index = selectedGenres?.firstIndex(where: { $0.id == genre.id }) {
            selectedGenres?.remove(at: index)
        } else {
            selectedGenres?.append(genre)
        }
    }
}
