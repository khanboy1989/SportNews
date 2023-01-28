//
//  ConnectionError.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

public protocol ConnectionError: Error{
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
