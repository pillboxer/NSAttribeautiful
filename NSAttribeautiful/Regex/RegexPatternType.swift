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
    case stylableArgumentMatch
    /// Matches any custom token, prefix or suffix
    case customTokensMatch
    /// Matches group indexes directly succeeding a stylable argument
    case groupIndexMatch
    /// Matches extraneous whitespace at the end of a document
    case extraneousWhitespaceMatch
    /// Matches explicit line space parameter
    case lineSpaceMatch
    /// Matches one or more digits
    case oneOrMoreDigits
    
    /// The string literal pattern to hand to `NSRegularExpression`
    var pattern: String {
        switch self {
        case .groupContainerMatch:
            return RegexPattern.groupContainerPattern
        case .lineSpaceMatch:
            return RegexPattern.lineSpacingPattern
        case .groupsMatch:
            return RegexPattern.groupsPattern
        case .fontMatch:
            return RegexPattern.fontPattern
        case .sizeMatch:
            return RegexPattern.sizePattern
        case .colorMatch:
            return RegexPattern.colorPattern
        case .stylableArgumentMatch:
            return RegexPattern.stylableArgumentPattern
        case .customTokensMatch:
            return RegexPattern.customTokenPattern
        case .groupIndexMatch:
            return RegexPattern.groupIndexPattern
        case .extraneousWhitespaceMatch:
            return RegexPattern.extraneousWhitespacePattern
        case .oneOrMoreDigits:
            return RegexPattern.oneOrMoreDigits
        }
    }
}

fileprivate extension RegexPattern {
    
    /// The pattern for matching a group container
    static var groupContainerPattern: String {
        #"^\#(prefixToken)(?:\[\w+:\d+\.?\d*:\w+\])+(\#(lineSpacingPattern))?\#(suffixToken)"#
    }
    
    /// The pattern for matching an optional line spacing argument within a container
    static var lineSpacingPattern: String {
        #"\[spacing:\d+\]"#
    }
    
    /// The pattern for matching one or more digits within a string
    static var oneOrMoreDigits: String {
        #"\d+"#
    }
    
    /// The pattern for matching groups within a container
    static var groupsPattern: String {
        #"\[\w+:\d+\.?\d*:\w+\]"#
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
    static var stylableArgumentPattern: String {
         #"(?<=\#(prefixToken))[^\#(prefixToken)\#(suffixToken)]+(?=\#(suffixToken))"#
    }
    
    /// The pattern for matching a group index.
    /// The end of the document must directly succeed the index
    static var groupIndexPattern: String {
        #"(?<=\#(prefixToken))\[\d+(?:,\d+)*\](?=\#(suffixToken)\s*$)"#
    }
    
    /// The pattern for matching any custom token, prefix or suffix
    static var customTokenPattern: String {
        #"[\#(prefixToken)\#(suffixToken)]"#
    }
    
    /// The pattern for removing any whitespace before the end of a document
    static var extraneousWhitespacePattern: String {
        #"\s+$"#
    }
    
}
