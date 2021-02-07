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
        case .moreThanOneGroupContainerFound:
            return "More than one GroupContainer found in document."
        case .groupMatchFailed:
            return "Unable to match Group(s) in GroupContainer"
        }
    }
    
    /// The full formatted error message
    var errorDescription: String? {
        let prefix: String
        switch errorType {
        case .groupContainerMatching:
            prefix = "GROUPCONTAINER MATCHING ERROR"
        case .groupMatching:
            prefix = "GROUPMATCHING FORMATTING ERROR"
        default:
            prefix = "UNKNOWN ERROR"
        }
        return "\(prefix): \(rawDescription) | \(NSAttribeautifulError.usageMessage)"
    }
    
    
}
