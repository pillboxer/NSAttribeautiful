//
//  GroupIndexContainer.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 27/02/2021.
//

import Foundation

struct GroupIndexContainer {
    let indexes: [Int]
    
    init(_ indexString: String) {
        let withoutBrackets = indexString.filter { $0 != "[" && $0 != "]" }
        let commaSeparated = withoutBrackets.components(separatedBy: ",")
        indexes = commaSeparated.compactMap { Int($0) }
    }
    
    subscript(_ index: Int) -> Int? {
        indexes[safe: index]
    }
}
