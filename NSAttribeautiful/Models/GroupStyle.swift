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
    
    private var size: Double? {
        Double(group.size)
    }
    
    private var fontName: String {
        if let mapped = NSAttribeautiful.identifierFontMap[group.font] {
            DebugLogger.log(message: "Abbreviated font \(group.font) successfully matched. Apply font \(mapped)", minimumLogLevel: .verbose)
            return mapped
        }
        else {
            DebugLogger.log(message: "No abbreviated font found. Applying \(group.font)", minimumLogLevel: .verbose)
            return group.font
        }
    }
    
    #if os(iOS)
    var font: UIFont? {
        guard let size = size else {
            return nil
        }
        let fontSize = CGFloat(size)
        return FontHelper.fontWith(name: fontName, size: fontSize)
    }
    #else
    var font: NSFont? {
        guard let size = size else {
            return nil
        }
        let fontSize = CGFloat(size)
        return FontHelper.fontWith(name: fontName, size: fontSize)
    }
    #endif
    
    #if os(iOS)
    var color: UIColor? {
        UIColor(named: group.color, in: nil, compatibleWith: nil) ?? UIColor(named: group.color)
    }
    #else
    var color: NSColor? {
        NSColor(named: group.color, bundle: nil) ??  NSColor(named: group.color)
    }
    #endif
}
