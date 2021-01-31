//
//  NSAttribeautifulError.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// An enum representing errors thrown when formatting a document
enum NSAttribeautifulError: Int, LocalizedError {
    
    // MARK: - GroupContainerMatching
    case missingGroupContainer = 1000
    case moreThanOneGroupContainerFound = 1001
    
    /// The broader category of error
    var errorType: NSAttribeautifulErrorType {
        if rawValue >= 1000 && rawValue <= 2000 {
            return .groupContainerMatching
        }
        return .unknownError
    }
    
}
