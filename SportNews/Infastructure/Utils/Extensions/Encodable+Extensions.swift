//
//  Encodable+Extensions.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation

// MARK: - Encodable Extensions
public extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
