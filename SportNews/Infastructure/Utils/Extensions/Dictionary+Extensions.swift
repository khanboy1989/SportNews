//
//  Dictionary+Extensions.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation

// MARK: - Dictionary Extensions
public extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
