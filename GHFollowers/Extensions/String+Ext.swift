//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 28/07/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import Foundation

extension String
{
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
    
    func converToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
