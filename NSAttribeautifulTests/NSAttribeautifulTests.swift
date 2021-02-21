//
//  NSAttribeautifulTests.swift
//  NSAttribeautifulTests
//
//  Created by Henry Cooper on 31/01/2021.
//

import XCTest
@testable import NSAttribeautiful

class NSAttribeautifulTests: XCTestCase {
    
    override class func setUp() {
        NSAttribeautiful.debugLogLevel = .verbose
    }
    
    let customTokens = [";", ":", "*", "(", "!", "#", "¢", "©", "-", "_", "=", "¡", "|", #"\"#]
        
    func testAttribeautifiedStringIsStyledCorrectly() {
        let document = "≤[AmericanTypewriter:123:green][Copperplate:12.3:blue]≥ This should not be affected but ≤this≥, ≤that≥ and ≤this≥ should."
        let expected = NSMutableAttributedString(string: "This should not be affected but this, that and this should.")
        
        let firstFont = FontHelper.fontWith(name: "AmericanTypewriter", size: 123)
        let secondFont = FontHelper.fontWith(name: "Copperplate", size: 12.3)
        
        let firstColor = FontHelper.colorWith(name: "green")
        let secondColor = FontHelper.colorWith(name: "blue")
        
        let firstRange = NSRange(location: 32, length: 4)
        let secondRange = NSRange(location: 38, length: 4)
        let thirdRange = NSRange(location: 47, length: 4)
        
        expected.addAttribute(.font, value: firstFont!, range: firstRange)
        expected.addAttribute(.foregroundColor, value: firstColor!, range: firstRange)
        
        expected.addAttribute(.font, value: secondFont!, range: secondRange)
        expected.addAttribute(.foregroundColor, value: secondColor!, range: secondRange)
        
        expected.addAttribute(.font, value: secondFont!, range: thirdRange)
        expected.addAttribute(.foregroundColor, value: secondColor!, range: thirdRange)
        
        let instance = NSAttribeautiful(document: document)
        XCTAssertEqual(try? instance.beautifiedDocument(), expected)
    }
    
    func testIdenticalTokensThrowsError() {
        let token = customTokens.randomElement()!
        let instance = NSAttribeautiful(document: "", customPrefix: token, customSuffix: token)
        do {
            let _ = try instance.beautifiedDocument()
        }
        catch let error {
            XCTAssertTrue(error as? NSAttribeautifulError == .identicalTokens)
            return
        }
        XCTAssertFalse(true)
    }

    override func tearDown() {
        RegexPattern.prefixToken = "≤"
        RegexPattern.suffixToken = "≥"
        NSAttribeautiful.identifierFontMap = [:]
    }

}
