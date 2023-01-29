//
//  NewsOverviewSceneDIContainer.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

/**
 NewsOverviewSceneDIContainer is responsible to hold the instances
 for ViewControllers, ViewModels, UsesCaes and Repositories
 DataTransferClass is injected into the DI container and
 it is injected by Repository
 
 Obviously ViewController needs to inject the viewmodel (NewsOverviewViewModel)
 and ViewModel is injecting the NewsOverviewUseCase and NewsOverviewUseCase injects the repository
 
 So the order as follows (in general almost in any flow):
 ViewController injects -> ViewModel
 ViewModel injects -> UseCase
 UseCase injects -> Repository
 Repository injects -> DataTransferService
 */

final class NewsOverviewSceneDIContainer {
    
    //Struct for necessary dependecies to be defined
    struct Dependecies {
        let apiDataTransfer: DataTransferService
    }
    
    private let dependecies: Dependecies
    
    init(dependecies: Dependecies) {
        self.dependecies = dependecies
    }
    
    // MARK: - Use Cases
    func makeNewsOverViewUseCase() -> NewsOverviewUseCase {
        return DefaultNewsOverviewUseCase(newsOverviewRepository: makeNewsOverviewRepository())
    }
    
    // MARK: - Repositories
    func makeNewsOverviewRepository() -> NewsOverViewRepository {
        return DefaultNewsOverviewRepository(dataTransferService: dependecies.apiDataTransfer)
    }
    
    // MARK: - ViewModel
    func makeNewOverViewViewModel(actions: NewsOverviewViewModelActions) -> NewsOverviewViewModel {
        return DefaultNewsOverviewViewModel(newsOverviewUseCase: makeNewsOverViewUseCase(), actions: actions)
    }
    
    //MARK: - Flow Coordinators
    func makeNewsOverviewFlowCoordinator(navigationController: BaseNavigationController) -> NewsOverviewFlowCoordinator {
        return NewsOverviewFlowCoordinator(navigationController: navigationController, dependecies: self)
    }
    
    //MARK: - NewsOverviewDetailsViewModel
    func makeNewsOverviewDetailsViewModel(sportData: SportData) -> NewsOverviewDetailsViewModel {
        return DefaultNewsOverviewDetailsViewModel(item: sportData)
    }
}

// This extension is specially for NewsOverViewCoordinator(whihc in this case holds the flow for NewsOverView) and creates the necessary ViewControllers on the flow.

//Here we needed two viewcontroller one is for Overview (for the news) the another one is for the Details (for the specific selected news) 
extension NewsOverviewSceneDIContainer: NewsOverviewFlowCoordinatorDependecies {
    
    //MARK: - NewsOverviewController
    func makeOverviewViewController(actions: NewsOverviewViewModelActions) -> NewsOverviewViewController {
        return NewsOverviewViewController(viewModel: makeNewOverViewViewModel(actions: actions))
    }
    
    //MARK: - NewsOverviewDetailsController
    func makeNewsOverviewDetailsViewController(sportData: SportData) -> NewsOverviewDetailsViewController {
        return NewsOverviewDetailsViewController(viewModel: makeNewsOverviewDetailsViewModel(sportData: sportData))
    }
}
