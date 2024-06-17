//
//  GFAvatarUIImageView.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 14/06/2024.
//

import UIKit

class GFAvatarUIImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    private let placeHolderImage = GFImages.placeHolder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.layer.cornerRadius     = 10
        self.clipsToBounds          = true
        self.image                  = placeHolderImage
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
