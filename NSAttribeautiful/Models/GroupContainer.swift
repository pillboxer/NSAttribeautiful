//
//  File 2.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

/// Found at the beginning of correctly formatted documents, a `GroupContainer` holds a variable amount of `Group` objects
struct GroupContainer: CustomStringConvertible {
    let groups: [Group]
    let lineSpacing: Int
    
    var description: String {
        var string = ""
        for i in 0..<groups.count {
            let group = groups[i]
            string.append("Group \(i)\n")
            string.append("Font: \(group.font)\n")
            string.append("Size: \(group.size)\n")
            string.append("Color: \(group.color)\n")
            if i < groups.count - 1 {
                string.append("\n")
            }
        }
        return string
    }
}
