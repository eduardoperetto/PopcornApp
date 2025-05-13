//
//  ErrorView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI

struct ErrorView: View {
    @State var state: ErrorViewState

    var body: some View {
        VStack(spacing: 32) {
            state.image
            Text(state.title)
            Text(state.description)
                .font(.caption)
                .multilineTextAlignment(.center)
            if let tryAgain = state.tryAgain {
                Button("Try again") { tryAgain() }
            }
        }
    }
}
