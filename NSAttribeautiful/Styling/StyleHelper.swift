//
//  FontHelper.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 20/02/2021.
//

import SwiftUI
#if os(iOS)
import UIKit
typealias FontType = UIFont
#elseif os(macOS)
import Cocoa
typealias FontType = NSFont
#endif

class StyleHelper {
    
    #if os(iOS)
    class func fontWith(name: String, size: CGFloat) -> UIFont? {
        FontType(name: name, size: size)
    }
    #else
    class func fontWith(name: String, size: CGFloat) -> NSFont? {
        FontType(name: name, size: size)
    }
    #endif
    
    @available(OSX 10.15, *)
    @available(iOS 13.0, *)
    class func font(_ font: FontType) -> Font {
        Font.custom(font.fontName, size: font.pointSize)
    }
    
    #if os(iOS)
    class func colorWith(name: String) -> UIColor? {
        UIColor(named: name)
    }
    #else
    class func colorWith(name: String) -> NSColor? {
        NSColor(named: name)
    }
    #endif
}


