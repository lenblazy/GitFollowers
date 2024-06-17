//
//  GFAlertContainerView.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 17/06/2024.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.backgroundColor       = .systemBackground
        self.layer.cornerRadius    = 10
        self.layer.borderWidth     = 2
        self.layer.borderColor     = UIColor.white.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
