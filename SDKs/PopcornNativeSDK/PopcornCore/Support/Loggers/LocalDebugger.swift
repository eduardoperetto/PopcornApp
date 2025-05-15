//
//  LocalDebugger.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 09/05/25.
//

import Foundation
import OSLog

public final class LocalDebugger: LoggerProtocol {
    private let osLogger = Logger(subsystem: "Popcorn", category: "LocalDebugger")

    public func i(_ message: String, tag: String) {
        osLogger.info("[\(tag)] \(message)")
    }

    public func d(_ message: String, tag: String) {
        osLogger.debug("[\(tag)] \(message)")
    }

    public func w(_ message: String, tag: String) {
        osLogger.warning("[\(tag)] \(message)")
    }

    public func e(_ message: String, tag: String) {
        osLogger.error("[\(tag)] \(message)")
    }

    public init() {}
}
