//
//  MovieDetailsViewState.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation
import PopcornCore

struct MovieDetailsViewState {
    var movie: MovieDetails?
    var error: ErrorViewState?
    var isLoading: Bool = false
}
