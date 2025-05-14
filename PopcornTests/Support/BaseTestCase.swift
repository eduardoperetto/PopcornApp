//
//  BaseTestCase.swift
//  PopcornTests
//
//  Created by Eduardo Raupp Peretto on 13/05/25.
//

import Foundation
@testable import Popcorn
import XCTest

open class BaseTestCase: XCTestCase {
    override open func setUp() {
        super.setUp()
        AppDI.container = .stub()
    }

    override open func tearDown() {
        super.tearDown()
        AppDI.container = .stub()
    }
}
