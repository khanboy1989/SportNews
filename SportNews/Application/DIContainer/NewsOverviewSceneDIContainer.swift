//
//  NewsOverviewSceneDIContainer.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

final class NewsOverviewSceneDIContainer {
    
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
    
    //MARK: - NewsOverviewController
    func makeOverviewViewController(actions: NewsOverviewViewModelActions) -> NewsOverviewViewController {
        return NewsOverviewViewController(viewModel: makeNewOverViewViewModel(actions: actions))
    }
}

extension NewsOverviewSceneDIContainer: NewsOverviewFlowCoordinatorDependecies {}
