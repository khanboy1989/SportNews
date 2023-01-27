//
//  NetworkConfig.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation

// MARK: - NetworkConfigurable
public protocol NetworkConfigurable {
    var baseURL: URL {get}
    var headers: [String: String] {get}
    var queryParameters: [String: String] {get}
}

// MARK: - ApiDataNetworkConfig
public struct ApiDataNetworkConfig: NetworkConfigurable {
    
    public var baseURL: URL
    public var headers: [String: String]
    public var queryParameters: [String: String]
    
    public init(baseURL: URL, headers: [String: String] = [:], queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
