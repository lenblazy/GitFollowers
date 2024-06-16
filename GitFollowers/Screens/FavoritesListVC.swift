//
//  FavoritesListVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 10/02/2024.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        PersistenceManager.retrieveFavorites { result in
            switch result{
                
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
        
    }
    
}
