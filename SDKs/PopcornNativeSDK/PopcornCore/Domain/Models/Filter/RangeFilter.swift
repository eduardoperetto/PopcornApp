//
//  RangeFilter.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

public struct RangeFilter<T: Comparable & Equatable>: Equatable {
    public var min: T?
    public var max: T?

    public init(min: T? = nil, max: T? = nil) {
        self.min = min
        self.max = max
    }
}
