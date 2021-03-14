//
//  StyleApplicator.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 13/02/2021.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// This class performs the work of actually applying the formatting to a document. It also takes care of removing the `GroupContainer`, returning a stripped, formatted document.
class StyleApplicator {
    
    /// The finalized instance of an `NSAttributedString`. No more manipulations are performed after this function returns
    static func attributedString(from document: String, styles: [GroupStyle], spacing: Int) -> NSAttributedString {
        let stripped = stripContainer(from: document)
        let styled = applyGroupStyles(styles, to: stripped)
        let attributed = applyLineSpacing(spacing, to: styled)
        DebugLogger.log(message: "Beautified String:\n\n\(attributed)", minimumLogLevel: .verbose)
        return attributed
    }
    
    /// Removes a `GroupContainer` from a `document`
    /// - Parameters:
    ///   - document: The `String` containing unformatted text.
    ///
    /// - Returns: The `document` without its `GroupContainer`
    static func stripContainer(from document: String) -> String {
        let pattern = RegexPattern.patternFor(.groupContainerMatch)
        guard let match = RegexHelper.firstMatchFor(pattern: pattern, in: document) else {
            return document
        }
        let replaced = document.replacingOccurrences(of: match, with: "")
        let trimmed = replaced.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed
    }
    
    /// Applies each `GroupStyle` to an argument in a document stripped of its container. If the number of arguments is greater than the number of `GroupStyle` instances, the last group style is applied
    static func applyGroupStyles(_ styles: [GroupStyle], to strippedDocument: String) -> NSAttributedString {
        let stylableArgumentPattern = RegexPattern.patternFor(.stylableArgumentMatch)
        let stylableArgumentMatches = RegexHelper.textCheckingResultsFor(pattern: stylableArgumentPattern, in: strippedDocument)
        let groupIndexPattern = RegexPattern.patternFor(.groupIndexMatch)
        let groupIndexMatch = RegexHelper.firstMatchFor(pattern: groupIndexPattern, in: strippedDocument)
        
        let attributed = NSMutableAttributedString(string: strippedDocument)
        for match in stylableArgumentMatches.reversed() {
            if let range = Range(match.range, in: strippedDocument),
               let matchIndex = stylableArgumentMatches.firstIndex(of: match) {
                let indexToUse = retrieveGroupStyleIndex(from: matchIndex, in: groupIndexMatch) ?? matchIndex
                let style = styles[safe: indexToUse] ?? styles.last
                let font = style?.font ?? .systemFont(ofSize: 12)
                let color = style?.color ?? .black
                let attributes = NSAttributedString.attributesWith(font: font, color: color)
                let argument = String(strippedDocument[range])
                DebugLogger.log(message: "Applying attributes \(attributes.description) to \(argument)\n", minimumLogLevel: .verbose)
                let attributedString = NSAttributedString(string: argument, attributes: attributes)
                attributed.replaceCharacters(in: match.range, with: attributedString)
            }
        }
        return cleanupExtraneousElementsFrom(attributed, argumentCount: stylableArgumentMatches.count)
        
    }
    
    static func applyLineSpacing(_ spacing: Int, to attributed: NSAttributedString) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: attributed)
        DebugLogger.log(message: "Applying line spacing of \(spacing)", minimumLogLevel: .verbose)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(spacing)
        mutable.addAttribute(.paragraphStyle, value: paragraphStyle, range: mutable.string.range())
        return mutable
    }
    
    static func retrieveGroupStyleIndex(from index: Int, in groupIndexString: String?) -> Int? {
        guard let groupIndexString = groupIndexString else {
            return nil
        }
        let groupIndexContainer = GroupIndexContainer(groupIndexString)
        return groupIndexContainer[index]
    }
    
    /// Replaces anything that doesn't belong in the beautified string
    static func cleanupExtraneousElementsFrom(_ document: NSAttributedString, argumentCount: Int) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: document)
        let blank = NSAttributedString(string: "")

        // Remove the group index if it exists
        let groupIndexPattern = RegexPattern.patternFor(.groupIndexMatch)
        if let groupIndexMatch = RegexHelper.textCheckingResultsFor(pattern: groupIndexPattern, in: document.string).first {
            DebugLogger.log(message: "Removing group index found at end of document", minimumLogLevel: .verbose)
            mutable.replaceCharacters(in: groupIndexMatch.range, with: blank)
        }
        
        // Remove the tokens
        let tokensPattern = RegexPattern.patternFor(.customTokensMatch)
        let tokenMatches = RegexHelper.textCheckingResultsFor(pattern: tokensPattern, in: mutable.string)
        if tokenMatches.count != argumentCount * 2 {
            DebugLogger.log(message: "⚠️ Token count mismatch, results may be unexpected ⚠️")
        }
        for match in tokenMatches.reversed() {
            mutable.replaceCharacters(in: match.range, with: blank)
        }
        
        // Remove extraneous white space
        let extraneousWhitespacePattern = RegexPattern.patternFor(.extraneousWhitespaceMatch)
        if let extraneousWhitespaceMatch = RegexHelper.textCheckingResultsFor(pattern: extraneousWhitespacePattern, in: mutable.string).first {
            DebugLogger.log(message: "Removing extraneous whitespace found at end of document", minimumLogLevel: .verbose)
            mutable.replaceCharacters(in: extraneousWhitespaceMatch.range, with: blank)
        }
        
        DebugLogger.log(message: "Outstanding tokens replaced", minimumLogLevel: .verbose)
        return mutable
    }

}
