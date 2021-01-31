//
//  NSAttribeautiful.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

class NSAttribeautiful {
    
    private let text: String
    
    /// Creates an instance of NSAttribeautiful
    /// - Parameters:
    ///   - toBeautify: The `String` containing unformatted text.
    init(toBeautify: String) {
        self.text = toBeautify
        DebugLogger.log(message: "For usage info, please visit https://github.com/pillboxer/NSAttribeautiful", minimumLogLevel: .verbose)
    }

    
}
