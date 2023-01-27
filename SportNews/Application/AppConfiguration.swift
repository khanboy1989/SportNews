//
//  AppConfiguration.swift
//  SportNews
//
//  Created by Serhan Khan on 27.01.23.
//

import Foundation

final class AppConfiguration {
    lazy var apiBaseURL: String = {
            guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
                fatalError("ApiBaseURL must not be empty in plist")
            }
            return apiBaseURL
        }()
}
