//
//  AppTabsView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import SwiftUI

struct AppTabsView: View {
    var body: some View {
        TabView {
            DiscoverHostView()
                .tabItem {
                    Label("Discover", systemImage: "popcorn")
                }
            LikeHostView()
                .tabItem {
                    Label("Liked", systemImage: "heart")
                }
            WatchLaterHostView()
                .tabItem {
                    Label("Watch Later", systemImage: "clock")
                }
        }.tint(.primaryForeground)
    }
}

#Preview {
    AppTabsView()
}
