//
//  File.swift
//  
//
//  Created by Henry Cooper on 31/01/2021.
//

import Foundation

class RegexHelper {
    
    /// Returns the first match from a regular expression
    static func firstMatchFor(pattern: NSRegularExpression, in document: String) -> String? {
        matchesFor(pattern: pattern, in: document).first
    }
    
    static func textCheckingResultsFor(pattern: NSRegularExpression, in document: String) -> [NSTextCheckingResult] {
        pattern.matches(in: document, options: [], range: document.range())
    }
    
    /// Finds the matches from a regular expression and hands them back as a `[String]` instead of an `[NSTextCheckingResult]`
    static func matchesFor(pattern: NSRegularExpression, in document: String) -> [String] {
        rangesFor(pattern: pattern, in: document).compactMap { String (document[$0]) }
    }
    
    private static func rangesFor(pattern: NSRegularExpression, in document: String) -> [Range<String.Index>] {
        let matches = textCheckingResultsFor(pattern: pattern, in: document)
        return matches.compactMap { Range($0.range, in: document) }
    }
    
}
