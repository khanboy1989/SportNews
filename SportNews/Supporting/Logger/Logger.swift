//
//  Logger.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

func printIfDebug(_ string: String) {
    #if DEBUG
    //swiftlint:disable next no_direct_standard_out_logs
    print(string)
    #endif
}
