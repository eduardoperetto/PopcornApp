//
//  MockLogger.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

@testable import Popcorn

final class MockLogger: LoggerProtocol {
    private(set) var infoCalls: [(message: String, tag: String)] = []
    private(set) var debugCalls: [(message: String, tag: String)] = []
    private(set) var warningCalls: [(message: String, tag: String)] = []
    private(set) var errorCalls: [(message: String, tag: String)] = []

    func i(_ message: String, tag: String) {
        infoCalls.append((message, tag))
    }
    func d(_ message: String, tag: String) {
        debugCalls.append((message, tag))
    }
    func w(_ message: String, tag: String) {
        warningCalls.append((message, tag))
    }
    func e(_ message: String, tag: String) {
        errorCalls.append((message, tag))
    }
}
