//
//  NSAttribeautiful+Font.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 08/02/2021.
//

import Foundation

extension NSAttribeautiful {
    
    static var identifierFontMap: [String : String] = [:]
    /// On encountering the `abbreviation`, `NSAttribeautiful` will replace it with the desired `font`, thus allowing for shorter `Group` declarations in documents.
    /// - Parameters:
    ///   - abbreviation: The abbreviated identifier in the document.
    ///   - font: The target font
    public static func identifyAbbreviation(_ abbreviation: String, withFont font: String) {
        identifierFontMap[abbreviation] = font
    }

}
