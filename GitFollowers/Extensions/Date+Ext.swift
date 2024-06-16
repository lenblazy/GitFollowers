//
//  Date+Ext.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 16/06/2024.
//

import Foundation

extension Date {
    
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter   = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
