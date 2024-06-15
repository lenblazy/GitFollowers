//
//  UIViewController+ext.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 14/06/2024.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController{
    
    func presentGFAlert(title: String, message: String, buttonText: String){
        let alertVC = GFAlertVC(alertTitle: title, alertMessage: message, btnTitle: buttonText)
        alertVC.modalPresentationStyle   = .overFullScreen
        alertVC.modalTransitionStyle     = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator   = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in View: UIView){
        let emptryStateView = GFEmptyStateView(message: message)
        emptryStateView.frame = view.bounds
        view.addSubview(emptryStateView)
    }
    
}
