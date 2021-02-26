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
    private static let strippedDocumentWithCustomTokens = "Here is a @document^ that may or may not need to be @@styled^"
    private static let strippedDocumentWithoutTokens = "Here is a document that may or may not need to be styled"
    
    private func strippedDocumentWithCustomTokens(prefix: Character, suffix: Character) -> NSAttributedString {
        NSAttributedString(string: "Here is a \(prefix)document\(suffix) that may or may not need to be \(prefix)styled\(suffix)")
    }
    
    func testStrippingADocumentWithGroupContainerStripsCorrectly() {
        let expected = NSAttribeautifulTests.documentWithoutGroupContainer
        let stripped = StyleApplicator.stripContainer(from: NSAttribeautifulTests.documentWithGroupContainer)
        XCTAssertEqual(stripped, expected)
    }
    
    func testOutstandingTokensAreReplacedFromStrippedDocumentWithStandardTokens() {
        let expected = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithoutTokens)
        let document = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithStandardTokens)
        let withoutTokens = StyleApplicator.replacingOutstandingTokensFrom(document, argumentCount: 2)
        XCTAssertEqual(expected, withoutTokens)
    }
    
    func testOustandingTokensAreReplacedFromStrippedDocumentWithCustomTokens() {
        let prefix = customTokens.randomElement()!
        let suffix = customTokens.randomElement()!
        RegexPattern.useCustomPrefix(prefix)
        RegexPattern.useCustomSuffix(suffix)
        let expected = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithoutTokens)
        let document = strippedDocumentWithCustomTokens(prefix: prefix, suffix: suffix)
        let withoutTokens = StyleApplicator.replacingOutstandingTokensFrom(document, argumentCount: 2)
        XCTAssertEqual(expected, withoutTokens)
    }
        
}
