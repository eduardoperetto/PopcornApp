//
//  ScaleButtonStyle.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
