//
//  NSAttribeautifulTests.swift
//  NSAttribeautifulTests
//
//  Created by Henry Cooper on 31/01/2021.
//

import XCTest
@testable import NSAttribeautiful

class NSAttribeautifulTests: XCTestCase {

    override func tearDown() {
        NSAttribeautiful.prefixToken = "≤"
        NSAttribeautiful.suffixToken = "≥"
    }

}
