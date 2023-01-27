//
//  AppDIContainer.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation

class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(networkService: apiDataNetwork)
    }()
}
