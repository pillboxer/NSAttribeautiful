//
//  FontHelper.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 20/02/2021.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

class FontHelper {
    
    #if os(iOS)
    class func fontWith(name: String, size: CGFloat) -> UIFont? {
        UIFont(name: name, size: size)
    }
    #else
    class func fontWith(name: String, size: CGFloat) -> NSFont? {
        NSFont(name: name, size: size)
    }
    #endif
    
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
