//
//  String+RunTime.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation

public extension Int {
    var formattedRuntime: String {
        let hours = self / 60
        let minutes = self % 60
        return "\(hours)h \(minutes)m"
    }
}
