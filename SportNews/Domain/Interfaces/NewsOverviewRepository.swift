//
//  NewsOverviewRepository.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation
protocol NewsOverViewRepository {
    @discardableResult
    func fetchNewsOverview(completion: @escaping (Result<NewsOverviewResponseDTO, Error>) -> Void) -> Cancellable?
}
