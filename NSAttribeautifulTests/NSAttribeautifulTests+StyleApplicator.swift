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
    
    private static let indexes = "[0,0,1,2]"
    private static let documentWithGroupContainer = "≤[atr:12.3:blue][system:1:green]≥ Here is a document"
    private static let documentWithoutGroupContainer = "Here is a document"
    private static let strippedDocumentWithStandardTokens = "Here is a ≤document≥ that may or may not need to be ≤styled≥. It has ≤a group index container≥ at the ≤end≥ ≤\(indexes)≥"
    private static let strippedDocumentWithoutTokens = "Here is a document that may or may not need to be styled. It has a group index container at the end"
    
    private static func strippedDocumentWithCustomTokens(prefix: Character, suffix: Character) -> NSAttributedString {
        NSAttributedString(string: "Here is a \(prefix)document\(suffix) that may or may not need to be \(prefix)styled\(suffix). It has \(prefix)a group index container\(suffix) at the \(prefix)end\(suffix) \(prefix)\(indexes)\(suffix)")
    }
    
    func testStrippingADocumentWithGroupContainerStripsCorrectly() {
        let expected = NSAttribeautifulTests.documentWithoutGroupContainer
        let stripped = StyleApplicator.stripContainer(from: NSAttribeautifulTests.documentWithGroupContainer)
        XCTAssertEqual(stripped, expected)
    }
    
    func testOutstandingTokensAreReplacedFromStrippedDocumentWithStandardTokens() {
        let expected = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithoutTokens)
        let document = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithStandardTokens)
        let withoutTokens = StyleApplicator.cleanupExtraneousElementsFrom(document, argumentCount: 5    )
        XCTAssertEqual(expected, withoutTokens)
    }
    
    func testOustandingTokensAreReplacedFromStrippedDocumentWithCustomTokens() {
        let prefix = customTokens.randomElement()!
        let suffix = customTokenNotIncluding(prefix)
        RegexPattern.useCustomPrefix(prefix)
        RegexPattern.useCustomSuffix(suffix)
        let expected = NSAttributedString(string: NSAttribeautifulTests.strippedDocumentWithoutTokens)
        let document = NSAttribeautifulTests.strippedDocumentWithCustomTokens(prefix: prefix, suffix: suffix)
        let withoutTokens = StyleApplicator.cleanupExtraneousElementsFrom(document, argumentCount: 5)
        XCTAssertEqual(expected, withoutTokens)
    }
    
    func testGroupIndexContainerInitializedWithStringHasCorrectIndexes() {
        let expected = [3,2,0,1]
        let groupIndexContainer = GroupIndexContainer("3,2,0,1")
        XCTAssertEqual(expected, groupIndexContainer.indexes)
    }
    
    func testSubscriptingGroupIndexContainerReturnsCorrectIndex() {
        let expected = 7
        let groupIndexContainer = GroupIndexContainer("9,1,7,1,9,7")
        XCTAssertEqual(expected, groupIndexContainer[2])
    }
    
    func testCorrectGroupIndexesAreReturnedFromStrippedDocument() {
        let prefix = customTokens.randomElement()!
        let suffix = customTokenNotIncluding(prefix)
        RegexPattern.useCustomPrefix(prefix)
        RegexPattern.useCustomSuffix(suffix)
        let document = NSAttribeautifulTests.strippedDocumentWithCustomTokens(prefix: prefix, suffix: suffix)
        let groupIndexPattern = RegexPattern.patternFor(.groupIndexMatch)
        let groupIndexMatchString = RegexHelper.firstMatchFor(pattern: groupIndexPattern, in: document.string)
        let expected = [0,0,1,2]
        var matches: [Int] = []
        for i in 0..<expected.count {
            if let index = StyleApplicator.retrieveGroupStyleIndex(from: i, in: groupIndexMatchString) {
                matches.append(index)
            }
        }
        XCTAssertEqual(expected, matches)
    }
        
}
