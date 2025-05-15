//
//  DiscoverHostView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Combine
import SwiftUI

struct DiscoverHostView: View {
    @StateObject private var coordinator: Coordinator<DiscoverRoute> = DiscoverCoordinator()

    var body: some View {
        CoordinatorHostView(coordinator: coordinator)
    }
}
