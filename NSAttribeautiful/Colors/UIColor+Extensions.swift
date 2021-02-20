//
//  UIColor+Extensions.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 20/02/2021.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init?(named name: String) {
        self.init(named: name, in: Bundle(for: NSAttribeautiful.self), compatibleWith: nil)
    }

}
