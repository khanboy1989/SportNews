//
//  DefaultNewsOverviewRepository.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

final class DefaultNewsOverviewRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultNewsOverviewRepository: NewsOverViewRepository {
    func fetchNewsOverview(completion: @escaping (Result<NewsOverviewResponseDTO, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = ApiEndPoints.getNewsOverview()
        task.networkTask = dataTransferService.request(with: endpoint, completion: {
            result in
            switch result {
            case let .success(news):
                completion(.success(news))
            case let .failure(error):
                completion(.failure(error))
            }
        })
        return task
    }
}
