//
//  NewsOverviewFlowCoordinatorDependecies.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

protocol NewsOverviewFlowCoordinatorDependecies {
    func makeOverviewViewController(actions: NewsOverviewViewModelActions) -> NewsOverviewViewController
}

class NewsOverviewFlowCoordinator: Coordinator {
    var navigationController: BaseNavigationController
    let dependecies: NewsOverviewFlowCoordinatorDependecies
    
    init(navigationController: BaseNavigationController,
         dependecies: NewsOverviewFlowCoordinatorDependecies) {
        self.navigationController = navigationController
        self.dependecies = dependecies
    }
    
    func start() {
        let actions = NewsOverviewViewModelActions(showDetails: showDetails)
        let vc = dependecies.makeOverviewViewController(actions: actions)
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
    private func showDetails() {
        
    }
    
}
