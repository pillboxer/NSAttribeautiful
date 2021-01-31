import XCTest
@testable import NSAttribeautiful

extension NSAttribeautifulTests {
    
    private static let documentWithStandardTokens = "≤[myFont:123:green][anotherFont:12.3:blue]≥ This should not be affected but ≤this≥, ≤that≥ and ≤this≥ should."
    private static let containerWithStandardTokens = "≤[myFont:123:green][anotherFont:12.3:blue]≥"
    private static let groupsWithoutTokens = ["[myFont:123:green]","[anotherFont:12.3:blue]"]
    
    func testGroupContainerIsMatchedFromDocument() {
        let expected = NSAttribeautifulTests.containerWithStandardTokens
        let pattern = RegexPattern.patternFor(.groupContainerMatch)
        let document = NSAttribeautifulTests.documentWithStandardTokens
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
    func testGroupsAreMatchedFromContainer() {
        let expected = NSAttribeautifulTests.groupsWithoutTokens
        let pattern = RegexPattern.patternFor(.groupsMatch)
        let document = NSAttribeautifulTests.containerWithStandardTokens
        let matches = RegexHelper.matchesFor(pattern: pattern, in: document)
        XCTAssertEqual(matches, expected)
    }
    
    func testFontIsMatchedFromGroup() {
        let expected = "anotherFont"
        let document = NSAttribeautifulTests.groupsWithoutTokens[1]
        let pattern = RegexPattern.patternFor(.fontMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
    func testSizeIsMatchedFromGroup() {
        let expected = "12.3"
        let document = NSAttribeautifulTests.groupsWithoutTokens[1]
        let pattern = RegexPattern.patternFor(.sizeMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
    func testColorIsMatchedFromGroup() {
        let expected = "blue"
        let document = NSAttribeautifulTests.groupsWithoutTokens[1]
        let pattern = RegexPattern.patternFor(.colorMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
}

// MARK: - Custom Token Tests

extension NSAttribeautifulTests {
    
    func testGroupContainerIsMatchedFromDocumentWithCustomTokens() {
        let customPrefix = "@"
        let customSuffix = "@"
        
        NSAttribeautiful.prefixToken = customPrefix
        NSAttribeautiful.suffixToken = customSuffix
        
        let document = NSAttribeautifulTests.documentWithStandardTokens
            .replacingOccurrences(of: "≤", with: customPrefix)
            .replacingOccurrences(of: "≥", with: customSuffix)
        let expected = NSAttribeautifulTests.containerWithStandardTokens
            .replacingOccurrences(of: "≤", with: customPrefix)
            .replacingOccurrences(of: "≥", with: customSuffix)
        
        let pattern = RegexPattern.patternFor(.groupContainerMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        
        XCTAssertEqual(match, expected)
    }
    
    func testCustomTokensAreEscaped() {
        let expected = [#"\+"#, #"\-"#]
        NSAttribeautiful.prefixToken = "+"
        NSAttribeautiful.suffixToken = "-"
        XCTAssertEqual([NSAttribeautiful.prefixToken, NSAttribeautiful.suffixToken], expected)
    }
    
    func testGroupContainerMatchPatternIsCorrectAfterConfiguringCustomTokens() {
        let expected = #"^\😀(?:\[\w+:\d+\.?\d+:\w+\])+\😀"#
        NSAttribeautiful.prefixToken = "😀"
        NSAttribeautiful.suffixToken = "😀"
        let pattern = MatchingAction.groupContainerMatch.pattern
        XCTAssertEqual(pattern, expected)
    }

}
