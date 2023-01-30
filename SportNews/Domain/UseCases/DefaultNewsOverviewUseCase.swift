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
    
    //executes the request
    //currently we are checking if the response is succeed becuase we do not have
    //persistance DB saving implemented.
    //In future this class will be more useful
    //if we add persistance memory saving functionality
    func execute(completion: @escaping (Result<NewsOverviewResponseDTO, Error>) -> Void) -> Cancellable? {
        return self.newsOverviewRepository.fetchNewsOverview() { result in
            switch result {
            case let.success(data):
                completion(.success(data))
            case let.failure(error):
                completion(.failure(error))
            }
        }
    }
}
