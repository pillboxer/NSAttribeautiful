//
//  DebugLogLevel.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// Represent the verbosity (or lack of) of console messages
public enum DebugLogLevel: Int {
    
    /// Receive no messages (not recommended)
    case none
    /// Receive errors only (this is the default setting)
    case errors
    /// Receive all debugging messages
    case verbose
    
}
