//
//  BaseViewController.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation
import UIKit
import Combine
/**
 BaseViewController handles the common implementation for each viewcontroller
 in order to avoid code duplication for example show alert in case any error
 or for each view controller setting the color or etc.
 */
class BaseViewController: UIViewController, Alertable {
 
    var disposeBag = Set<AnyCancellable>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        executeRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    open func executeRequests() {}
    
    open func configureObservers() {}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag.forEach { $0.cancel() }
        disposeBag.removeAll()
    }
    
    open func didReceiveNetworkError(error: String) {
        showAlert(message: error)
    }
}
