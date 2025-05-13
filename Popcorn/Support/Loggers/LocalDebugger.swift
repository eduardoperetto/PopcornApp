//
//  LocalDebugger.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation
import OSLog

final class LocalDebugger: LoggerProtocol {
    private let osLogger = Logger(subsystem: "Popcorn", category: "LocalDebugger")

    func i(_ message: String, tag: String) {
        osLogger.info("[\(tag)] \(message)")
    }

    func d(_ message: String, tag: String) {
        osLogger.debug("[\(tag)] \(message)")
    }

    func w(_ message: String, tag: String) {
        osLogger.warning("[\(tag)] \(message)")
    }

    func e(_ message: String, tag: String) {
        osLogger.error("[\(tag)] \(message)")
    }
}
