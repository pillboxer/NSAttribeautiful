//
//  NSAttribeautifulLabelRepresentable.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 21/03/2021.
//

import SwiftUI

#if os(iOS)
/// A lightweight `UIViewRepresentable` for SwiftUI.
@available(iOS 13.0.0, *)
public struct NSAttribeautifulLabelRepresentable: UIViewRepresentable {
    
    let beautifiedDocument: NSAttributedString
    var alignment: NSTextAlignment = .natural
    
    public func makeUIView(context: Context) -> some UIView {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.attributedText = beautifiedDocument
        label.textAlignment = alignment
        return label
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
}
#elseif os(macOS)
/// A lightweight `NSViewRepresentable` for SwiftUI.
@available(OSX 10.15.0, *)
public struct NSAttribeautifulLabelRepresentable: NSViewRepresentable {
    
    let beautifiedDocument: NSAttributedString
    var alignment: NSTextAlignment = .natural
    
    public func makeNSView(context: Context) -> some NSView {
        let label = NSTextField()
        label.isEditable = false
        label.isBezeled = false
        label.drawsBackground = false
        label.maximumNumberOfLines = 0
        label.isSelectable = false
        label.attributedStringValue = beautifiedDocument
        label.alignment = alignment
        return label
    }
    
    public func updateNSView(_ nsView: NSViewType, context: Context) {
        //
    }
    
}
#endif

