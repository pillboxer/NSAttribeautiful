import XCTest
@testable import NSAttribeautiful

extension NSAttribeautifulTests {
    
    private static let documentWithStandardTokens = #"≤[myFont:123:green][anotherFont:12.3:blue][spacing:20]≥ This should not be affected but \n\n≤this≥, ≤that≥ and ≤this≥ should. ≤\#(groupIndexArguments)≥"#
    
    private static let groupIndexArguments = "[0,1,2,3,4]"
    private static let containerWithStandardTokens = "≤[myFont:123:green][anotherFont:12.3:blue][spacing:20]≥"
    private static let containerSpacing = "[spacing:20]"
    private static let groupsWithoutTokens = ["[myFont:123:green]","[anotherFont:12.3:blue]"]
    private static let strippedDocumentWithStandardTokens = "This should not be affected but ≤this≥, ≤that≥ and ≤this≥ should."
    private static let argumentsWithoutTokens = ["this", "that", "this"]
    
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
    
    func testArgumentsAreMatchedFromDocument() {
        let expected = NSAttribeautifulTests.argumentsWithoutTokens
        let document = NSAttribeautifulTests.strippedDocumentWithStandardTokens
        let pattern = RegexPattern.patternFor(.stylableArgumentMatch)
        let match = RegexHelper.matchesFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
    func testGroupIndexesAreMatchedFromArgumentsFromDocument() {
        let expected = NSAttribeautifulTests.groupIndexArguments
        let document = NSAttribeautifulTests.documentWithStandardTokens
        let pattern = RegexPattern.patternFor(.groupIndexMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
    func testExtraneousWhitespaceIsMatchedFromDocument() {
        let expected = "          "
        let document = "Here is a document          "
        let pattern = RegexPattern.patternFor(.extraneousWhitespaceMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(expected, match)
    }
    
    func testLineSpacingIsMatchedFromDocument() {
        let expected = NSAttribeautifulTests.containerSpacing
        let document = NSAttribeautifulTests.documentWithStandardTokens
        let pattern = RegexPattern.patternFor(.lineSpaceMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(expected, match)
    }
    
}

// MARK: - Custom Token Tests
extension NSAttribeautifulTests {
    
    private func documentWithCustomTokens(prefix: Character, suffix: Character) -> String {
        "\(prefix)[myFont:123:green][anotherFont:12.3:blue]\(suffix) This should not be affected but \(prefix)this\(suffix), \(prefix)that\(suffix) and \(prefix)this\(suffix) should. \(prefix)\(NSAttribeautifulTests.groupIndexArguments)\(suffix)"
    }
    
    private func containerWithCustomTokens(prefix: Character, suffix: Character) -> String {
        "\(prefix)[myFont:123:green][anotherFont:12.3:blue]\(suffix)"
    }
    
    private func strippedDocumentWithCustomTokens(prefix: Character, suffix: Character) -> String {
        "This should not be affected but \(prefix)this\(suffix), \(prefix)that\(suffix) and \(prefix)this\(suffix) should."
    }
    
    func testGroupContainerIsMatchedFromDocumentWithCustomTokens() {
        let randomPrefix = customTokens.randomElement()!
        let randomSuffix = customTokenNotIncluding(randomPrefix)
        let instance = NSAttribeautiful(document: "", customPrefix: randomPrefix, customSuffix: randomSuffix)
        let _ = try? instance.beautifiedDocument()
        let expected = containerWithCustomTokens(prefix: randomPrefix, suffix: randomSuffix)
        let pattern = RegexPattern.patternFor(.groupContainerMatch)
        let document = documentWithCustomTokens(prefix: randomPrefix, suffix: randomSuffix)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
    func testCustomTokensAreEscaped() {
        let prefix = customTokens.randomElement()!
        let suffix = customTokenNotIncluding(prefix)
        let expected = [#"\\#(prefix)"#, #"\\#(suffix)"#]
        RegexPattern.useCustomPrefix(prefix)
        RegexPattern.useCustomSuffix(suffix)
        XCTAssertEqual([RegexPattern.prefixToken, RegexPattern.suffixToken], expected)
    }
    
    func testGroupContainerMatchPatternIsCorrectAfterConfiguringCustomTokens() {
        let prefix = customTokens.randomElement()!
        let suffix = customTokenNotIncluding(prefix)
        let expected = #"^\\#(prefix)(?:\[\w+:\d+\.?\d*:\w+\])+(\[spacing:\d+\])?\\#(suffix)"#
        RegexPattern.useCustomPrefix(prefix)
        RegexPattern.useCustomSuffix(suffix)
        let pattern = MatchingAction.groupContainerMatch.pattern
        XCTAssertEqual(pattern, expected)
    }
    
    func testArgumentsAreMatchedFromDocumentWithCustomTokens() {
        let prefix = customTokens.randomElement()!
        let suffix = customTokenNotIncluding(prefix)
        RegexPattern.useCustomPrefix(prefix)
        RegexPattern.useCustomSuffix(suffix)
        let expected = NSAttribeautifulTests.argumentsWithoutTokens
        let document = strippedDocumentWithCustomTokens(prefix: prefix, suffix: suffix)
        let pattern = RegexPattern.patternFor(.stylableArgumentMatch)
        let match = RegexHelper.matchesFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }
    
    func testGroupIndexesAreMatchedFromArgumentsInDocumentWithCustomTokens() {
        let expected = NSAttribeautifulTests.groupIndexArguments
        let prefix = customTokens.randomElement()!
        let suffix = customTokenNotIncluding(prefix)
        RegexPattern.useCustomPrefix(prefix)
        RegexPattern.useCustomSuffix(suffix)
        let document = documentWithCustomTokens(prefix: prefix, suffix: suffix)
        let pattern = RegexPattern.patternFor(.groupIndexMatch)
        let match = RegexHelper.firstMatchFor(pattern: pattern, in: document)
        XCTAssertEqual(match, expected)
    }

}
