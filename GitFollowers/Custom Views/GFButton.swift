//
//  GFButton.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 13/06/2024.
//

import UIKit

class GFButton: UIButton {

    // Default initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // For story board initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom initializer
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor    = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
