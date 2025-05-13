//
//  WatchLaterHostView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI

struct WatchLaterHostView: View {
    @StateObject private var coordinator: Coordinator<WatchLaterRoute> = WatchLaterCoordinator()

    var body: some View {
        CoordinatorHostView(coordinator: coordinator)
    }
}
