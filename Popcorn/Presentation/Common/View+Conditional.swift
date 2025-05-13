//
//  View+Conditional.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool,
                             transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
