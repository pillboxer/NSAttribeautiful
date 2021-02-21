//
//  NSAttribeautiful+ErrorDescriptions.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

extension NSAttribeautifulError {
    
    /// Usage message that is added to the suffix of every error message.
    private static let usageMessage = "Please ensure usage is correct according to latest documentation"
    
    /// The description of an error omitting its error type and generic usage message
    private var rawDescription: String {
        switch self {
        case.missingGroupContainer:
            return "Could not find a GroupContainer at the beginning of document."
        case .groupMatchFailed:
            return "Unable to match Group(s) in GroupContainer"
        case .identicalTokens:
            return "Custom prefix and custom suffix are identical."
        }
    }
    
    /// The full formatted error message
    var errorDescription: String {
        return "🚨 \(rawDescription) | \(NSAttribeautifulError.usageMessage) 🚨"
    }
    
    
}
