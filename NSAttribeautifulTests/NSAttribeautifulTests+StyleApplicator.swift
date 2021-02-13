//
//  NSAttribeautifulTests+StyleApplicator.swift
//  NSAttribeautifulTests
//
//  Created by Henry Cooper on 13/02/2021.
//

import Foundation
import XCTest

@testable import NSAttribeautiful

extension NSAttribeautifulTests {
    
    private static let documentWithGroupContainer = "≤[atr:12.3:blue][system:1:green]≥ Here is a document"
    private static let documentWithoutGroupContainer = "Here is a document"
    
    func testStrippingADocumentWithGroupContainerStripsCorrectly() {
        let expected = NSAttribeautifulTests.documentWithoutGroupContainer
        let stripped = StyleApplicator.stripContainer(from: NSAttribeautifulTests.documentWithGroupContainer)
        XCTAssertEqual(stripped, expected)
    }
    
}
