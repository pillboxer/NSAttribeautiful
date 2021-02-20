//
//  NSAttribeautiful+ViewController.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 20/02/2021.
//

import Foundation
import UIKit

extension NSAttribeautiful {
    
    /// The `debugViewController` allows you to see a preview of your beautified document alongside the document itself
    public func debugViewController() -> UIViewController? {
        if let beautified = try? beautifiedDocument() {
            let controller = NSAttribeautifulViewController(document: document, beautified: beautified)
            return controller
        }
        return nil
    }
}
