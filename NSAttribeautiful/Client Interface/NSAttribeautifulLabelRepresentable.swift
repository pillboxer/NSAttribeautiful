//
//  NSAttribeautifulLabelRepresentable.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 21/03/2021.
//

import SwiftUI

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
