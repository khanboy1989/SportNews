//
//  BaseNavigationController.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
