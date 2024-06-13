//
//  SearchVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 10/02/2024.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView   = UIImageView()
    let tfUserName      = GFTextField()
    let btnCallToAction = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTF()
        configureBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    private func configureTF() {
        view.addSubview(tfUserName)
        
        NSLayoutConstraint.activate([
            tfUserName.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            tfUserName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tfUserName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            tfUserName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureBtn() {
        view.addSubview(btnCallToAction)
        
        NSLayoutConstraint.activate([
            btnCallToAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            btnCallToAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            btnCallToAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            btnCallToAction.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
