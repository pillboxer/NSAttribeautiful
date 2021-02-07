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
    ///Matches the color in a group
    case colorMatch
    
    /// The string literal pattern to hand to `NSRegularExpression`
    var pattern: String {
        switch self {
        case .groupContainerMatch:
            return MatchingAction.groupContainerPattern
        case .groupsMatch:
            return MatchingAction.groupsPattern
        case .fontMatch:
            return MatchingAction.fontPattern
        case .sizeMatch:
            return MatchingAction.sizePattern
        case .colorMatch:
            return MatchingAction.colorPattern
        }
    }
}

extension MatchingAction {
    
    /// The client selected prefix token (defaults to `≤`)
    private static var prefixToken: String { NSAttribeautiful.prefixToken }
    /// The client selected prefix token (defaults to `≥`)
    private static var suffixToken: String { NSAttribeautiful.suffixToken }
    
    /// The pattern for matching a group container
    private static var groupContainerPattern: String {
        #"^\#(prefixToken)(?:\[\w+:\d+\.?\d+:\w+\])+\#(suffixToken)"#
    }
    
    /// The pattern for matching groups within a container
    private static var groupsPattern: String {
        #"\[\w+:\d+\.?\d+:\w+\]"#
    }
    
    /// The pattern for matching the font from a group
    ///
    /// * **(?<=\[)** Positive lookbehind asserts a word must be preceeded by an opening bracket
    private static var fontPattern: String {
        #"(?<=\[)\w+"#
    }
    
    /// The pattern for matching the size from a group
    ///
    /// * **(?<=\:)** Positive lookbehind asserts any value must be preceeded by a colon.
    private static var sizePattern: String {
        #"(?<=\:)\d+\.?\d+"#
    }
    
    /// The pattern for matching the size from a group
    ///
    /// * **(?<=\:)** Positive lookbehind asserts any value must be preceeded by an opening bracket.
    ///
    /// * **(?=\])** Positive lookahead asserts any value must be preceeded by an opening bracket
    private static var colorPattern: String {
        #"(?<=\:)\w+(?=\])"#
    }
    
    /// The pattern for matching a single string to be styled from a document.
    /// The styled string must be enclosed in the client selected prefix tokens.
    private static var styleableOperandPattern: String {
        #"\#(prefixToken).+\#(suffixToken)"#
    }
    
}
