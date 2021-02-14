//
//  NSAttributedString+Extensions.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 14/02/2021.
//

#if os(iOS)
import UIKit
import SwiftUI
#else
import Cocoa
#endif

extension NSAttributedString {
    
    #if os(iOS)
    class func attributesWith(font: UIFont, color: UIColor) -> [NSAttributedString.Key : Any] {
        return [.font : font, .foregroundColor : color]
    }
    #else
    class func attributesWith(font: NSFont, color: NSColor) -> [NSAttributedString.Key : Any] {
        return [.font : font, .foregroundColor : color]
    }
    #endif
}
