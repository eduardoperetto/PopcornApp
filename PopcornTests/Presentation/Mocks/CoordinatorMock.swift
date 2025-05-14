//
//  CoordinatorMock.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

@testable import Popcorn
import SwiftUI

final class CoordinatorMock<Route: Hashable>: Coordinator<Route> {
    private(set) var navigatedRoutes: [Route] = []

    init(rootRoute: Route) {
        super.init(rootRoute: rootRoute)
    }

    override func buildView(for route: Route) -> AnyView {
        AnyView(EmptyView())
    }

    override func navigate(to route: Route) {
        navigatedRoutes.append(route)
        super.navigate(to: route)
    }
}
