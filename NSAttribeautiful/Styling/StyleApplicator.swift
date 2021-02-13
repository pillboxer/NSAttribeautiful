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
//    static func attributedString(from document: String) -> NSAttributedString {
//
//    }
    
    static func stripContainer(from document: String) -> String {
        let pattern = RegexPattern.patternFor(.groupContainerMatch)
        guard let match = RegexHelper.firstMatchFor(pattern: pattern, in: document) else {
            return document
        }
        let replaced = document.replacingOccurrences(of: match, with: "")
        let trimmed = replaced.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed
    }
    
}
