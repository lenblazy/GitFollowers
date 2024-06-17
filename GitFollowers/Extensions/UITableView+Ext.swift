//
//  UITableView+Ext.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 17/06/2024.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() -> Void {
        tableFooterView = UIView(frame: .zero)
    }
    
}
