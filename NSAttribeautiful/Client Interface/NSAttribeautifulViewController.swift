//
//  NSAttribeautifulViewController.swift
//  NSAttribeautiful
//
//  Created by Henry Cooper on 14/02/2021.
//

import UIKit

class NSAttribeautifulViewController: UIViewController {
    
    // MARK: - IBOutlets
    // MARK: - Properties
    private let document: String
    private var documentLabel: UILabel?
    
    // MARK: - Initialization
    init(document: String, beautified: NSAttributedString) {
        self.document = #"\#(document)"#
        super.init(nibName: nil, bundle: Bundle(for: NSAttribeautiful.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addDocumentLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateDocumentLabelToShowDocument()
    }
    
    private func addDocumentLabel() {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "NSAttribeautiful"
        label.numberOfLines = 0
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        let centerX = label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let width = label.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        let top = label.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
        let all = [centerX, top, width]
        all.forEach { $0.isActive = true }
        self.documentLabel = label
        view.addConstraints(all)
    }
    
    private func animateDocumentLabelToShowDocument() {
        UIView.animate(withDuration: 3, animations: {
            self.documentLabel?.alpha = 0
        }) { _ in
            self.documentLabel?.text = "Your document:\n\n \(self.document)"
            UIView.animate(withDuration: 3) {
                self.documentLabel?.alpha = 1
            }
        }
    }
    
}
