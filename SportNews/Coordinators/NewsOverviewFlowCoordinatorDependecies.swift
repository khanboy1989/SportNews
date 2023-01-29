//
//  NewsOverviewFlowCoordinatorDependecies.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

protocol NewsOverviewFlowCoordinatorDependecies {
    func makeOverviewViewController(actions: NewsOverviewViewModelActions) -> NewsOverviewViewController
    func makeNewsOverviewDetailsViewController(sportData: SportData) -> NewsOverviewDetailsViewController
}

//Creates and holds the instance of the given
//UINavigationController
//NOTE: Coordinator holds the navigation events so actions are declared here.
class NewsOverviewFlowCoordinator: Coordinator {
    var navigationController: BaseNavigationController
    let dependecies: NewsOverviewFlowCoordinatorDependecies
    
    //MARK: - Initialize the Coordinator for ViewModel
    init(navigationController: BaseNavigationController,
         dependecies: NewsOverviewFlowCoordinatorDependecies) {
        self.navigationController = navigationController
        self.dependecies = dependecies
    }
    
    //Here start the NewsOverviewFlow with actions
    //Actions are a specific struct where we take the click events and receive it
    //as an navigation event from the viewcontroller
    //ViewModel is receiving the click events and triggering the relevant action from the coordinator
    //When we are creating the ViewController at the beginning we need to pass the actions struct as a parameter so that we will handle the navigation events from the coordinator.
    func start() {
        let actions = NewsOverviewViewModelActions(showDetails: showDetails)
        let vc = dependecies.makeOverviewViewController(actions: actions)
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
    // MARK: - ShowDetails
    /**
     Shows the details from selected item from the tableview (selected sport data)
     */
    private func showDetails(sportData: SportData) {
        let vc = dependecies.makeNewsOverviewDetailsViewController(sportData: sportData)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
