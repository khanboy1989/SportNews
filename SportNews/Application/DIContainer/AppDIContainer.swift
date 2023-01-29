//
//  AppDIContainer.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation

/**
 AppDIContainer holds the top level classes that are supposed to injected by classes
 such as ViewModel, Repository and UseCases

 In this specific case we try to hold necessary services like NetworkSerive (and config)
 SecurityService and etc.
 
 Here also DIContainer holds the children DIContainers, here we only needed one
 NewsOverViewDIContainer()
 
 In future if we need to define another flow (like UserRegistration/Login) we can define it here
 and we can pass the DataTransfer class as an parameter to it as well
 
 Injection order for the classes 
 ViewController injects -> ViewModel
 ViewModel injects -> UseCase, Coordinators
 UseCase injects -> Repository
 Repository injects -> DataTransferService
 */
class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(networkService: apiDataNetwork)
    }()
    
    //MARK: - DIContainer of Scenes
    
    /**
        NewsOverviewDIContainer in this case first defined
         DIContainer and initially we have paased the DataTransferService to it as a parameter
     */
    func makeNewsOverviewDIContainer() -> NewsOverviewSceneDIContainer {
        let dependecies = NewsOverviewSceneDIContainer.Dependecies(apiDataTransfer: apiDataTransferService)
        return NewsOverviewSceneDIContainer(dependecies: dependecies)
    }
}
