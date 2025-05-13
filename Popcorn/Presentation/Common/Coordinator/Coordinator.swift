//
//  Coordinator.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import SwiftUI

open class Coordinator<Route: Hashable>: ObservableObject {
    @Published private(set) var rootRoute: Route
    @Published private(set) var rootView: AnyView
    @Published var path = NavigationPath()

    init(rootRoute: Route, path: NavigationPath = NavigationPath()) {
        self.rootRoute = rootRoute
        self.path = path
        self.rootView = ProgressView().erased
        self.rootView = buildView(for: rootRoute)
    }

    func navigate(to route: Route) {
        AppDIContainer.shared.logger.d("navigate to \(route)", tag: "Coordinator")
        path.append(route)
    }

    func setRoot(_ route: Route) {
        AppDIContainer.shared.logger.d("setRoot to \(route)", tag: "Coordinator")
        rootRoute = route
        rootView = buildView(for: route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = .init()
    }

    func buildView(for route: Route) -> AnyView {
        fatalError("Coordinator buildView must be overridden")
    }
}

extension Coordinator: Equatable {
    public static func == (lhs: Coordinator<Route>, rhs: Coordinator<Route>) -> Bool {
        lhs.path == rhs.path && lhs.rootRoute == rhs.rootRoute
    }
}
