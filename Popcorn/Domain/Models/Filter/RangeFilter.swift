//
//  RangeFilter.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

struct RangeFilter<T: Comparable & Equatable>: Equatable {
    var min: T?
    var max: T?
}
