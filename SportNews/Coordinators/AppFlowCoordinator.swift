//
//  AppFlowCoordinator.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation
import UIKit

/**
 AppFlowCoordinator is responsible to start the flow after Launchscreen
 One of the benefit os using FlowCoordinator, we can change the initial flow
 depending on the requirements of our needs.
 
 For example: In future if we have another flow we can define it from here and start the flow
 in addition to this we can even decide if we are going to use a NavigationController or
 if our initial viewcontroller will be a normal UIViewController
 */
class AppFlowCoordinator: Coordinator{

    private let appDIContainer: AppDIContainer
    var navigationController: BaseNavigationController
   
    init(appDIContainer: AppDIContainer, navigationController: BaseNavigationController) {
        self.appDIContainer = appDIContainer
        self.navigationController = navigationController
    }
    
    /**
     Starts the defined flow
     for this case It is our NewsOverViewFlow with it's related DIContainer
     we are initializing the flow and it's DIContainer (note that each flow should have different DIContainer). For example: in future if we are going to have a UserRegistration/Login flow we should have something like
     UserLoginRegistrationDIContainer()
     **** FINALLY We will need to init the Flow coordinator for the related
     Flow, in this case it is NewsOverViewFlowCoordinator with a initial NavigationController/UIViewController
     */
    func start() {
        let newsOverviewDIContainer = appDIContainer.makeNewsOverviewDIContainer()
        let flow = newsOverviewDIContainer.makeNewsOverviewFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
