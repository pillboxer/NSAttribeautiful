//
//  NSAttribeautifulError.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// An enum representing errors thrown when formatting a document
enum NSAttribeautifulError: Equatable, LocalizedError {
    
    // MARK: - GroupContainer Matching
    case missingGroupContainer
    // MARK: - Group Matching
    case groupMatchFailed
    // MARK: - Token Repetition
    case identicalTokens
    
}
