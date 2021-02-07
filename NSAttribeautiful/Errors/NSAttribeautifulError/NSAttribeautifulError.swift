//
//  NSAttribeautifulError.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// An enum representing errors thrown when formatting a document
enum NSAttribeautifulError: Int, LocalizedError {
    
    // MARK: - GroupContainer Matching
    case missingGroupContainer = 1000
    case moreThanOneGroupContainerFound = 1001
    
    // MARK: - Group Matching
    case groupMatchFailed = 2000
    
    /// The broader category of error
    var errorType: NSAttribeautifulErrorType {
        if rawValue >= 1000 && rawValue < 2000 {
            return .groupContainerMatching
        }
        if rawValue >= 2000 && rawValue < 3000 {
            return .groupMatching
        }
        return .unknownError
    }
    
}
