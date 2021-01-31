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
    
    /// Finds the matches from a regular expression and hands them back as a `[String]` instead of an `[NSTextCheckingResult]`
    static func matchesFor(pattern: NSRegularExpression, in document: String) -> [String] {
        let matches = pattern.matches(in: document, options: [], range: document.range())
        return matches.compactMap { match in
            guard let range = Range(match.range, in: document) else {
                return nil
            }
            return String(document[range])
        }
    }
    
}
