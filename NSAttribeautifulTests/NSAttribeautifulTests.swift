//
//  NSAttribeautifulTests.swift
//  NSAttribeautifulTests
//
//  Created by Henry Cooper on 31/01/2021.
//

import XCTest
@testable import NSAttribeautiful

class NSAttribeautifulTests: XCTestCase {
    
    // FIXME: - 
    func testAttribeautifiedStringIsStyledCorrectly() {
        let document = "≤[myFont:123:green][anotherFont:12.3:blue]≥ This should not be affected but ≤this≥, ≤that≥ and ≤this≥ should."
        let instance = NSAttribeautiful(document: document)
        XCTAssertFalse(true)
    }

    override func tearDown() {
        RegexPattern.prefixToken = "≤"
        RegexPattern.suffixToken = "≥"
        NSAttribeautiful.identifierFontMap = [:]
    }

}
