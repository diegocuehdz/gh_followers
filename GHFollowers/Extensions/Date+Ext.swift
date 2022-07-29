//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 28/07/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import Foundation

extension Date
{
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
