//
//  File.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

extension NSAttribeautiful {
    
    /// The token that prefixes a `GroupContainer` and any subsequent `StylableOperands`
    public static var prefixToken = "≤" {
        didSet {
            prefixToken = #"\\#(prefixToken)"#
        }
    }
    
    /// The token that suffixes a `GroupContainer` and any subsequent `StylableOperands`
    public static var suffixToken = "≥" {
        didSet {
            suffixToken = #"\\#(suffixToken)"#
        }
    }

}
