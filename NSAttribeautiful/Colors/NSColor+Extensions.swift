//
//  NSColor+Extensions.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 20/02/2021.
//

#if !os(iOS)
import Cocoa

extension NSColor {
    
    convenience init?(named name: String) {
        self.init(named: name, bundle: Bundle(for: NSAttribeautiful.self))
    }

}
#endif

