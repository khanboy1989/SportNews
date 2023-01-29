//
//  Strings + Extensions.swift
//  Currex
//
//  Created by Serhan Khan on 28/02/2021.
//

import Foundation

extension String {
    var nullify: String? {
        return isEmpty || self == "" ? nil : self
    }
    
    func toDate(withFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
}
