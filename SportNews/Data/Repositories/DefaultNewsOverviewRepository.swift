//
//  DefaultNewsOverviewRepository.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

//All the business logic calls are handled here
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
        //check if there is an instance for the same is cancelled before sending the request to server to avoid uncessary calls
        guard !task.isCancelled else { return nil}
        task.networkTask = dataTransferService.request(with: endpoint, completion: {
            result in
            switch result {
                //onSuccess
            case let .success(news):
                completion(.success(news))
                //onFailure
            case let .failure(error):
                completion(.failure(error))
            }
        })
        return task
    }
}
