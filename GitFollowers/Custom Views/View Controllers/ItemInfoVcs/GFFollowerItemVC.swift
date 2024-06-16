//
//  GFFollowerItemVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 16/06/2024.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.setType(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.setType(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
}
