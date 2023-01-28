//
//  FetchRecentNewsOverviewUseCase.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

protocol NewsOverviewUseCase {
    func execute(completion: @escaping (Result<NewsOverviewResponseDTO, Error>) -> Void) -> Cancellable?
}

// Use case is responsible to connect between viewmodel and
// related repository
final class DefaultNewsOverviewUseCase: NewsOverviewUseCase {

    private let newsOverviewRepository: NewsOverViewRepository
    
    init(newsOverviewRepository: NewsOverViewRepository) {
        self.newsOverviewRepository = newsOverviewRepository
    }
    
    func execute(completion: @escaping (Result<NewsOverviewResponseDTO, Error>) -> Void) -> Cancellable? {
        return self.newsOverviewRepository.fetchNewsOverview(completion: completion)
    }
}
