//
//  UIViewController+ext.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 14/06/2024.
//

import UIKit

extension UIViewController{
    
    func presentGFAlert(title: String, message: String, buttonText: String){
        let alertVC = GFAlertVC(alertTitle: title, alertMessage: message, btnTitle: buttonText)
        alertVC.modalPresentationStyle   = .overFullScreen
        alertVC.modalTransitionStyle     = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
}
