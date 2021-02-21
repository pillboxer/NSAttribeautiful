//
//  RegexPattern.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// Provides easy access to regex patterns for different types of format matching
struct RegexPattern {
    
    /// The client selected prefix token (defaults to `≤`)
    static var prefixToken: String = "≤" {
        didSet {
            DebugLogger.log(message: "Setting custom prefix to \(prefixToken)", minimumLogLevel: .verbose)
            if prefixToken.count == 1 {
                prefixToken = #"\\#(prefixToken)"#
            }
        }
    }
    /// The client selected prefix token (defaults to `≥`)
    static var suffixToken: String = "≥" {
        didSet {
            DebugLogger.log(message: "Setting custom prefix to \(suffixToken)", minimumLogLevel: .verbose)
            if suffixToken.count == 1 {
                suffixToken = #"\\#(suffixToken)"#
            }
        }
    }
    
    /// Returns a specific pattern for an action
    static func patternFor(_ type: MatchingAction) -> NSRegularExpression {
        try! NSRegularExpression(pattern: type.pattern)
    }
    
}
