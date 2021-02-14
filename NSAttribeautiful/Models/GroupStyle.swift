//
//  GroupStyle.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 08/02/2021.
//

import Foundation
#if os(iOS)
import UIKit
import SwiftUI
#else
import Cocoa
#endif

/// Members of a `GroupStyle` instance contain the directly applicable styling attributes for a given `Group`. 
struct GroupStyle {
    
    private let group: Group
    
    // MARK: - Initialization
    init(group: Group) {
        self.group = group
    }
    
    #if os(iOS)
    var font: UIFont? {
        guard let doubleSize = Double(group.size)else {
            return nil
        }
        let size = CGFloat(doubleSize)
        let fontName = NSAttribeautiful.identifierFontMap[group.font] ?? group.font
        return UIFont(name: fontName, size: size)
    }
    #else
    var font: NSFont? {
        guard let doubleSize = Double(group.size)else {
            return nil
        }
        let size = CGFloat(doubleSize)
        let fontName = NSAttribeautiful.identifierFontMap[group.font] ?? group.font
        return NSFont(name: fontName, size: size)
    }
    #endif
    
    // FIXME: - NSColor also
    var color: UIColor? {
        UIColor(named: group.color, in: Bundle(for: NSAttribeautiful.self), compatibleWith: nil)
    }
    
    
}
