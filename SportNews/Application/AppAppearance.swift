//
//  AppAppearance.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation
import UIKit

final class AppAppearance {
    static func setupAppearance(){
        UINavigationBar.appearance().barTintColor = Asset.Colors.black.color
        UINavigationBar.appearance().tintColor = Asset.Colors.black.color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Asset.Colors.black.color]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Asset.Colors.black.color]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().prefersLargeTitles = true
    }
}
