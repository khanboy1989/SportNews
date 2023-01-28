//
//  AppFlowCoordinator.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation
import UIKit

class AppFlowCoordinator: Coordinator{

    private let appDIContainer: AppDIContainer
    var navigationController: BaseNavigationController
   
    init(appDIContainer: AppDIContainer, navigationController: BaseNavigationController) {
        self.appDIContainer = appDIContainer
        self.navigationController = navigationController
    }
    
    func start() {
        let newsOverviewDIContainer = appDIContainer.makeNewsOverviewDIContainer()
        let flow = newsOverviewDIContainer.makeNewsOverviewFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
