//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 13/06/2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch (result){
            case .success(let followers): print(followers)
            case .failure(let error): self.presentGFAlert(title: "Bad Stuff Happened", message: error.rawValue, buttonText: "Ok")
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
