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
}
