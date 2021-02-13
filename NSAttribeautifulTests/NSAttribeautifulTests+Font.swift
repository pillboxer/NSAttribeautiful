//
//  NSAttribeautifulTests+Font.swift
//  NSAttribeautifulTests
//
//  Created by Henry Cooper on 08/02/2021.
//

import Foundation

import XCTest
@testable import NSAttribeautiful

extension NSAttribeautifulTests {
    
    private static let abbreviatedFontName = "atr"
    private static let targetFontName = "American Typewriter"
    private static let containerWithAbbreviatedFont = "≤[atr:12.3:blue]≥"
    
    func testAddingAnAbbreviatedFontAddsToMap() {
        let abbreviation = NSAttribeautifulTests.abbreviatedFontName
        let expected = NSAttribeautifulTests.targetFontName
        NSAttribeautiful.identifyAbbreviation(abbreviation, withFont: expected)
        let value = NSAttribeautiful.identifierFontMap[abbreviation]
        XCTAssertEqual(value, expected)
    }
    
    func testAddingAnAbbreviatedFontResultsInCorrectUIFont() {
        let expected = UIFont(name: NSAttribeautifulTests.targetFontName, size: 12.3)
        NSAttribeautiful.identifyAbbreviation("atr", withFont: NSAttribeautifulTests.targetFontName)
        let group = Group(font: "atr", size: "12.3", color: "blue")
        let groupStyle = GroupStyle(group: group)
        XCTAssertEqual(groupStyle.font, expected)
    }
    
}
