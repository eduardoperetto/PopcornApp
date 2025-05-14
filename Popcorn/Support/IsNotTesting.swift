//
//  IsNotTesting.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation

var isNotTesting: Bool {
    !ProcessInfo.processInfo.arguments.contains("-isTesting")
}
