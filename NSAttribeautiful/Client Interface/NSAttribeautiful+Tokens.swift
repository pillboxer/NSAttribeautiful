//
//  File.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

extension NSAttribeautiful {
    
    public static var prefixToken = "≤" {
        didSet {
            prefixToken = #"\\#(prefixToken)"#
        }
    }
    public static var suffixToken = "≥" {
        didSet {
            suffixToken = #"\\#(suffixToken)"#
        }
    }

}
