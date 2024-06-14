//
//  GFAlertVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 13/06/2024.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView = UIView()
    let labelTitle      = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let labelMessage    = GFBodyLabel(textAlignment: .center)
    let btnAction       = GFButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle: String?
    var alertMessage: String?
    var btnTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String? = nil, alertMessage: String? = nil, btnTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.btnTitle = btnTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
    }
    
    private func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor       = .systemBackground
        containerView.layer.cornerRadius    = 10
        containerView.layer.borderWidth     = 2
        containerView.layer.borderColor     = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
   
    private func configureTitleLabel() {
        containerView.addSubview(labelTitle)
        labelTitle.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            labelTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            labelTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            labelTitle.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureButton() {
        containerView.addSubview(btnAction)
        btnAction.setTitle(btnTitle ?? "OK", for: .normal)
        btnAction.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            btnAction.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            btnAction.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            btnAction.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            btnAction.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(labelMessage)
        labelMessage.text = alertMessage ?? "Unable to complete request"
        labelMessage.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            labelMessage.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            labelMessage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            labelMessage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            labelMessage.bottomAnchor.constraint(equalTo: btnAction.topAnchor, constant: -8),
            
        ])
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
