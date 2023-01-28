//
//  UseCase.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation
protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
