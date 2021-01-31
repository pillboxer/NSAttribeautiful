//
//  RegexPattern.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// Provides easy access to regex patterns for different types of format matching
struct RegexPattern {
    
    /// Returns a specific pattern for an action
    static func patternFor(_ type: MatchingAction) -> NSRegularExpression {
        try! NSRegularExpression(pattern: type.pattern)
    }
    
}
