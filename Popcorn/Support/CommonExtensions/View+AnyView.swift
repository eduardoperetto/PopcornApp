//
//  View+AnyView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import SwiftUI

extension View {
    var erased: AnyView {
        AnyView(self)
    }
}
