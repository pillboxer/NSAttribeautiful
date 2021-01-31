//
//  File.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// Writes messages to the console
class DebugLogger {
    
    private static let logPrefix = "** NSAttribeautiful ** |"
    
    /// Logs a message only if the client's `DebugLogLevel` is equal or greater than the minimum specified by the caller
    /// - Parameters:
    ///   - message: The message to log
    ///   - minimumLogLevel: The minimum verbosity of the client needed to show the log
    static func log(message: String?, minimumLogLevel: DebugLogLevel = .errors) {
        let debugLogLevel = NSAttribeautiful.debugLogLevel
        guard let message = message,
            debugLogLevel.rawValue >= minimumLogLevel.rawValue else {
            return
        }
        print("\(logPrefix) \(message)")
    }
    
}
