//
//  GFRepoItemVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 16/06/2024.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.setType(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.setType(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
    
}
