//
//  OptionalWrapper.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

public enum OptionalWrapper<T: SelectionPickable>: Hashable {
    case none
    case some(T)

    public var description: String {
        switch self {
        case .none: "Not selected"
        case let .some(value): value.name
        }
    }

    public init(_ value: T?) {
        if let value {
            self = .some(value)
        } else {
            self = .none
        }
    }
}

extension OptionalWrapper: CaseIterable {
    public static var allCases: [OptionalWrapper] {
        var allCases = T.allCases.map { self.some($0) }
        allCases.append(.none)
        return allCases
    }
}
