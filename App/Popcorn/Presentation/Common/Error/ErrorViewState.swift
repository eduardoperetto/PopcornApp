//
//  ErrorViewState.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI

struct ErrorViewState {
    let image: Image
    let title: String
    let description: String
    let tryAgain: (() -> Void)?

    init(
        image: Image = Self.defaultImage,
        title: String,
        description: String,
        tryAgain: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.description = description
        self.tryAgain = tryAgain
    }
}

extension ErrorViewState {
    static var defaultImage: Image = .init(systemName: "exclamationmark.triangle")
}
