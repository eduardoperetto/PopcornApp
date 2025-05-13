//
//  SelectionPickable.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

protocol SelectionPickable: Hashable, Identifiable, Equatable, CaseIterable {
    var name: String { get }
}

extension Optional where Wrapped: SelectionPickable {
    var wrapOptional: OptionalWrapper<Wrapped> {
        get { .init(self) }
        set(wrappedValue) {
            if case let .some(value) = wrappedValue {
                self = value
            } else {
                self = nil
            }
        }
    }
}
