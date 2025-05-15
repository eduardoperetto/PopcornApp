//
//  MovieListViewState.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation
import PopcornCore

struct MovieListViewState {
    var movies: [Movie] = []
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    var error: ErrorViewState?
    var titleSearchQuery: String = ""
    var selectedFilters: FilterOptions = .init()
    var actions: Actions = .init()

    struct Actions {
        let onMovieTapped: (Movie) -> Void
        let onMovieCellAppeared: (Movie) -> Void

        init(onMovieTapped: @escaping (Movie) -> Void = { _ in }, onMovieCellAppeared: @escaping (Movie) -> Void = { _ in }) {
            self.onMovieTapped = onMovieTapped
            self.onMovieCellAppeared = onMovieCellAppeared
        }
    }
}
