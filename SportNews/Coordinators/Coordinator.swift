//
//  Coordinator.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//
import Foundation
import UIKit

protocol Coordinator {
    var navigationController: BaseNavigationController {get set}
    func start()
}
