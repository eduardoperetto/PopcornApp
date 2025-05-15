//
//  DateRangeFilter.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

public struct DateRangeFilter: Equatable {
    public var start: String?
    public var end: String?

    public init(start: String? = nil, end: String? = nil) {
        self.start = start
        self.end = end
    }
}
