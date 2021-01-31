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
            return "Could not find a Group Container at the beginning of document."
        case .moreThanOneGroupContainerFound:
            return "More than one Group Container found in document."
        }
    }
    
    /// The full formatted error message
    var errorDescription: String? {
        let prefix: String
        switch errorType {
        case .groupContainerMatching:
            prefix = "GROUP CONTAINER MATCHING ERROR"
        default:
            prefix = "UNKNOWN ERROR"
        }
        return "\(prefix): \(rawDescription) | \(NSAttribeautifulError.usageMessage)"
    }
    
    
}
