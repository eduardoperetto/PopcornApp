//
//  DiscoverHostView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import SwiftUI

struct LikeHostView: View {
    @StateObject private var coordinator: Coordinator<LikeRoute> = LikeCoordinator()

    var body: some View {
        CoordinatorHostView(coordinator: coordinator)
    }
}
