//
//  Array+Extensions.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 14/02/2021.
//

import Foundation

extension Array {
    
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
}
