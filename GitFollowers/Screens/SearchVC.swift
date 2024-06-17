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
    
    var isUserNameEntered: Bool {
        return !tfUserName.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTF()
        configureBtn()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfUserName.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = GFImages.ghLogo
        
        let topConstraint: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraint),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    private func configureTF() {
        view.addSubview(tfUserName)
        tfUserName.delegate = self
        
        NSLayoutConstraint.activate([
            tfUserName.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            tfUserName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tfUserName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            tfUserName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureBtn() {
        view.addSubview(btnCallToAction)
        btnCallToAction.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            btnCallToAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            btnCallToAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            btnCallToAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            btnCallToAction.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUserNameEntered else {
            self.presentGFAlert(title: "Empty Username", message: "Please enter the username. we need to know who we are looking for. 😃", buttonText: "OK")
            return
            
        }
        
        tfUserName.resignFirstResponder()
        
        let followersVC = FollowerListVC(username: tfUserName.text!)
        navigationController?.pushViewController(followersVC, animated: true)
    }

}

extension SearchVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
    
}
