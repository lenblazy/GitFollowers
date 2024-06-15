//
//  UserInfoVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 15/06/2024.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutViews()
        getUserInfo()
    }
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let user): DispatchQueue.main.async {
                self.add(childVc: GFUserInfoHeaderVC(user: user), to: self.headerView)
            }
            case .failure(let error): self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonText: "Ok")
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    private func layoutViews(){
        itemViews.append(contentsOf: [headerView, itemViewOne, itemViewTwo])
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        itemViewOne.backgroundColor = .systemRed
        itemViewTwo.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
        
    }
    
    private func add(childVc: UIViewController, to containerView: UIView){
        addChild(childVc)
        containerView.addSubview(childVc.view)
        childVc.view.frame = containerView.bounds
        childVc.didMove(toParent: self)
    }
    
}
