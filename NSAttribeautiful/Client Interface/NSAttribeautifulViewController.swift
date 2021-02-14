//
//  NSAttribeautifulViewController.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 14/02/2021.
//

import UIKit

class NSAttribeautifulViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var documentLabel: UILabel!
    @IBOutlet private weak var beautifiedLabel: UILabel!
    
    // MARK: - Properties
    private let document: String
    private let beautified: NSAttributedString
    
    // MARK: - Initialization
    init(document: String, beautified: NSAttributedString) {
        self.document = document
        self.beautified = beautified
        super.init(nibName: nil, bundle: Bundle(for: NSAttribeautiful.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        documentLabel.text = document
        beautifiedLabel.attributedText = beautified
    }
    
}
