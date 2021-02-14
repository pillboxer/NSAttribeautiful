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
    
    private static let strippedDocumentWithStandardTokens = "Here is a ≤document≥ that may or may not need to be ≤styled≥"
    private static let strippedDocumentWithCustomTokens = "Here is a @document^ that may or may not need to be @styled^"
    private static let strippedDocumentWithoutTokens = "Here is a document that may or may not need to be styled"
    
    func testStrippingADocumentWithGroupContainerStripsCorrectly() {
        let expected = NSAttribeautifulTests.documentWithoutGroupContainer
        let stripped = StyleApplicator.stripContainer(from: NSAttribeautifulTests.documentWithGroupContainer)
        XCTAssertEqual(stripped, expected)
    }
    
    func testOutstandingTokensAreReplacedFromStrippedDocumentWithStandardTokens() {
        let expected = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithoutTokens)
        let document = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithStandardTokens)
        let withoutTokens = StyleApplicator.replacingOutstandingTokensFrom(document)
        XCTAssertEqual(expected, withoutTokens)
    }
    
    func testOustandingTokensAreReplacedFromStrippedDocumentWithCustomTokens() {
        RegexPattern.prefixToken = "@"
        RegexPattern.suffixToken = "^"
        let expected = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithoutTokens)
        let document = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithCustomTokens)
        let withoutTokens = StyleApplicator.replacingOutstandingTokensFrom(document)
        XCTAssertEqual(expected, withoutTokens)
    }
    
}
