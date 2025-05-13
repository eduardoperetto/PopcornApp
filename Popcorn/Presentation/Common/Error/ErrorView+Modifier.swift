//
//  ErrorView+Modifier.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 11/05/25.
//

import SwiftUI

struct ErrorStateCatcher: ViewModifier {
    @State var errorState: ErrorViewState?

    func body(content: Content) -> some View {
        if let errorState {
            ErrorView(state: errorState)
        } else {
            content
        }
    }
}

extension View {
    func catchingErrorState(_ errorState: ErrorViewState?) -> some View {
        modifier(ErrorStateCatcher(errorState: errorState))
    }
}
