//
//  MatchingAction.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// Represents the type of action a regex pattern provides
enum MatchingAction {
    
    /// Matches the group container at the beginning of a string
    case groupContainerMatch
    /// Matches the group(s) in a group container
    case groupsMatch
    /// Matches the font in a group
    case fontMatch
    /// Matches the size in a group
    case sizeMatch
    /// Matches the color in a group
    case colorMatch
    /// Matches the stylable argument in a group
    case stylableArgument
    /// Matches any custom token, prefix or suffix
    case customTokens
    
    /// The string literal pattern to hand to `NSRegularExpression`
    var pattern: String {
        switch self {
        case .groupContainerMatch:
            return RegexPattern.groupContainerPattern
        case .groupsMatch:
            return RegexPattern.groupsPattern
        case .fontMatch:
            return RegexPattern.fontPattern
        case .sizeMatch:
            return RegexPattern.sizePattern
        case .colorMatch:
            return RegexPattern.colorPattern
        case .stylableArgument:
            return RegexPattern.styleableArgumentPattern
        case .customTokens:
            return RegexPattern.customTokenPattern
        }
    }
}

fileprivate extension RegexPattern {
    
    /// The pattern for matching a group container
    static var groupContainerPattern: String {
        #"^\#(prefixToken)(?:\[\w+:\d+\.?\d*:\w+\])+\#(suffixToken)"#
    }
    
    /// The pattern for matching groups within a container
    static var groupsPattern: String {
        #"\[\w+:\d+\.?\d+:\w+\]"#
    }
    
    /// The pattern for matching the font from a group
    ///
    /// * **(?<=\[)** Positive lookbehind asserts a word must be preceeded by an opening bracket
    static var fontPattern: String {
        #"(?<=\[)\w+"#
    }
    
    /// The pattern for matching the size from a group
    ///
    /// * **(?<=\:)** Positive lookbehind asserts any value must be preceeded by a colon.
    static var sizePattern: String {
        #"(?<=\:)\d+\.?\d*"#
    }
    
    /// The pattern for matching the size from a group
    ///
    /// * **(?<=\:)** Positive lookbehind asserts any value must be preceeded by an opening bracket.
    ///
    /// * **(?=\])** Positive lookahead asserts any value must be preceeded by an opening bracket
    static var colorPattern: String {
        #"(?<=\:)\w+(?=\])"#
    }
    
    /// The pattern for matching a single string to be styled from a document.
    /// The styled string must be enclosed in the client selected prefix tokens.
    static var styleableArgumentPattern: String {
        let pattern = #"(?<=\#(prefixToken))[^\#(prefixToken)\#(suffixToken)]+(?=\#(suffixToken))"#
        print(pattern)
        return pattern
    }
    
    /// The pattern for matching any custom token, prefix or suffix
    static var customTokenPattern: String {
        #"[\#(prefixToken)\#(suffixToken)]"#
    }
    
}
