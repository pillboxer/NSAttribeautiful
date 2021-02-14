//
//  StyleApplicator.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 13/02/2021.
//

import Foundation

/// This class performs the work of actually applying the formatting to a document. It also takes care of removing the `GroupContainer`, returning a stripped, formatted document.
class StyleApplicator {
    
    /// The finalized instance of an `NSAttributedString`. No more manipulations are performed after this function returns
    static func attributedString(from document: String, styles: [GroupStyle]) -> NSAttributedString {
        let stripped = stripContainer(from: document)
        return applyGroupStyles(styles, to: stripped)
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
        let pattern = RegexPattern.patternFor(.stylableArgument)
        let matches = RegexHelper.textCheckingResultsFor(pattern: pattern, in: strippedDocument)
        let attributed = NSMutableAttributedString(string: strippedDocument)
        for match in matches.reversed() {
            if let range = Range(match.range, in: strippedDocument),
               let matchIndex = matches.firstIndex(of: match),
               let style = styles[safe: matchIndex] ?? styles.last {
                
                let font = style.font ?? .systemFont(ofSize: 12)
                let color = style.color ?? .black
                let attributes = NSAttributedString.attributesWith(font: font, color: color)
                let argument = String(strippedDocument[range])
                let attributedString = NSAttributedString(string: argument, attributes: attributes)
                attributed.replaceCharacters(in: match.range, with: attributedString)
            }
        }
        return replacingOutstandingTokensFrom(attributed)
    }
    
    /// Replaces any outstanding prefixes or suffixes
    static func replacingOutstandingTokensFrom(_ document: NSAttributedString) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: document)
        let pattern = RegexPattern.patternFor(.customTokens)
        let matches = RegexHelper.textCheckingResultsFor(pattern: pattern, in: document.string)
        for match in matches.reversed() {
            let blank = NSAttributedString(string: "")
            mutable.replaceCharacters(in: match.range, with: blank)
        }
        return mutable
    }
    
}
