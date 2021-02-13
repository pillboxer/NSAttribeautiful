//
//  NSAttribeautiful.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

class NSAttribeautiful {
    
    private let document: String
    
    /// Creates an instance of NSAttribeautiful
    /// - Parameters:
    ///   - document: The `String` containing unformatted text.
    init(document: String, customPrefix: String? = nil, customSuffix: String? = nil) {
        self.document = document
        RegexPattern.prefixToken = customPrefix ?? RegexPattern.prefixToken
        RegexPattern.suffixToken = customSuffix ?? RegexPattern.suffixToken
        DebugLogger.log(message: "For usage info, please visit https://github.com/pillboxer/NSAttribeautiful", minimumLogLevel: .verbose)
    }
    
//    public func beautifiedDocument() throws -> NSAttributedString {
//        do {
//            let container = try GroupContainerRetriever.groupContainerFor(document)
//        }
//        catch {
//            
//        }
//    }

    
}
