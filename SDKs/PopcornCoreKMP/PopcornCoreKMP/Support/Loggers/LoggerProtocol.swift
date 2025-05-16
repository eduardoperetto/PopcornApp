//
//  LoggerProtocol.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//

import shared
import Foundation

public protocol LoggerProtocol {
    func i(_ message: String, tag: String)
    func d(_ message: String, tag: String)
    func w(_ message: String, tag: String)
    func e(_ message: String, tag: String)
}
