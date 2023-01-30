//
//  NetworkConfigurableMock.swift
//  SportNewsTests
//
//  Created by Serhan Khan on 30.01.23.
//

import Foundation

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://www.laola1.at/")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
