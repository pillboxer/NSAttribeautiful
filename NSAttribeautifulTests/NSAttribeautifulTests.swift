//
//  NSAttribeautifulTests.swift
//  NSAttribeautifulTests
//
//  Created by Henry Cooper on 31/01/2021.
//

import XCTest
@testable import NSAttribeautiful

class NSAttribeautifulTests: XCTestCase {
    
    func testAttribeautifiedStringIsStyledCorrectly() {
        let document = "≤[myFont:123:green][anotherFont:12.3:blue]≥ This should not be affected but ≤this≥, ≤that≥ and ≤this≥ should."
        print(UIColor(named: "green", in: Bundle(for: NSAttribeautiful.self), compatibleWith: nil)!)
        let instance = NSAttribeautiful(document: document)
        print(try! instance.beautifiedDocument())
        XCTAssertFalse(true)
    }

    override func tearDown() {
        RegexPattern.prefixToken = "≤"
        RegexPattern.suffixToken = "≥"
        NSAttribeautiful.identifierFontMap = [:]
    }

}
