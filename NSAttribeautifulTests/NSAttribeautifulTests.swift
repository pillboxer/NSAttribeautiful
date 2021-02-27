//
//  NSAttribeautifulTests.swift
//  NSAttribeautifulTests
//
//  Created by Henry Cooper on 31/01/2021.
//

import XCTest
@testable import NSAttribeautiful

class NSAttribeautifulTests: XCTestCase {
    
    static func documentWith(prefix: Character, suffix: Character) -> String {
        "\(prefix)[bod:123:green][al:12.3:blue][cp:0.5:red]\(suffix) This should not be affected but \(prefix)this\(suffix), \(prefix)that\(suffix) and \(prefix)this\(suffix) should. \(prefix)[1,2,0]\(suffix)"
    }

    let customTokens: String = #"¡€#¢∞§¶•ªº!@£$%^&*()_œ∑´®†¥¨^øπ“‘«\|æ…¬˚∆˙©ƒ∂ßå:;#"Ω≈ç√∫~µ≤≥÷?/¨"#
    
    func customTokenNotIncluding(_ token: Character) -> Character {
        customTokens.filter { $0 != token }.randomElement()!
    }
        
    func testAttribeautifiedStringIsStyledCorrectly() {
        
        let prefix = customTokens.randomElement()!
        let suffix = customTokenNotIncluding(prefix)
        
        print(prefix)
        print(suffix)
        
        NSAttribeautiful.identifyAbbreviation("bod", withFont: "BodoniSvtyTwoITCTT-Book")
        NSAttribeautiful.identifyAbbreviation("al", withFont: "Avenir-Light")
        NSAttribeautiful.identifyAbbreviation("cp", withFont: "Copperplate")
        
        let expected = NSMutableAttributedString(string: "This should not be affected but this, that and this should.")
        
        let firstFont = FontHelper.fontWith(name: "BodoniSvtyTwoITCTT-Book", size: 123)
        let secondFont = FontHelper.fontWith(name: "Avenir-Light", size: 12.3)
        let thirdFont = FontHelper.fontWith(name: "Copperplate", size: 0.5)
        
        let firstColor = FontHelper.colorWith(name: "green")
        let secondColor = FontHelper.colorWith(name: "blue")
        let thirdColor = FontHelper.colorWith(name: "red")
        
        let firstRange = NSRange(location: 32, length: 4)
        let secondRange = NSRange(location: 38, length: 4)
        let thirdRange = NSRange(location: 47, length: 4)
        
        expected.addAttribute(.font, value: secondFont!, range: firstRange)
        expected.addAttribute(.foregroundColor, value: secondColor!, range: firstRange)
        
        expected.addAttribute(.font, value: thirdFont!, range: secondRange)
        expected.addAttribute(.foregroundColor, value: thirdColor!, range: secondRange)
        
        expected.addAttribute(.font, value: firstFont!, range: thirdRange)
        expected.addAttribute(.foregroundColor, value: firstColor!, range: thirdRange)
        
        let document = NSAttribeautifulTests.documentWith(prefix: prefix, suffix: suffix)
        let instance = NSAttribeautiful(document: document, customPrefix: prefix, customSuffix: suffix)
        
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
        RegexPattern.useCustomPrefix("≤")
        RegexPattern.useCustomSuffix("≥")
        NSAttribeautiful.identifierFontMap = [:]
        NSAttribeautiful.debugLogLevel = .errors
    }

}
