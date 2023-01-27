//
//  Alertable.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation
import UIKit

//Global Alertable Implementation in order to handle
//Popup messages like error messages or any information for user
public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
