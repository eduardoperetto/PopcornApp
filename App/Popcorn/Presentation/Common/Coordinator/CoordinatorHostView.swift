//
//  CoordinatorHostView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI

struct CoordinatorHostView<R: Hashable>: View {
    @StateObject var coordinator: Coordinator<R>

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.rootView
                .navigationDestination(for: R.self) { route in
                    coordinator.buildView(for: route)
                }
        }
    }
}
