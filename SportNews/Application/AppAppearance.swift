//
//  AppAppearance.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation
import UIKit

final class AppAppearance{
    static func setupAppearance(){
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().prefersLargeTitles = true
    }
}
