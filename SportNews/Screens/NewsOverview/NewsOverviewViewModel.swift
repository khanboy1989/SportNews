//
//  NewsOverviewViewModel.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

struct NewsOverviewViewModelActions {
    let showDetails: () -> Void
}

protocol NewsOverviewInputViewModel {
    func showDetails()
    func fetchNewsOverview()
}

protocol NewsOverviewOutputViewModel {
    var screenTitle: String { get }
    var newsScreenState: Observable<ScreenState<NewsOverviewResponseDTO>> { get }
}

protocol NewsOverviewViewModel: NewsOverviewInputViewModel, NewsOverviewOutputViewModel {}

final class DefaultNewsOverviewViewModel: NewsOverviewViewModel {
    
    private let newsOverviewUseCase: NewsOverviewUseCase
    private let actions: NewsOverviewViewModelActions?
    private var newsLoadTask: Cancellable? { willSet { newsLoadTask?.cancel() } }
   
    init(newsOverviewUseCase: NewsOverviewUseCase,
         actions: NewsOverviewViewModelActions? = nil ) {
        self.newsOverviewUseCase = newsOverviewUseCase
        self.actions = actions
    }
    
    func showDetails() {
        
    }
    
    func fetchNewsOverview() {
        fetch(screenState: newsScreenState)
    }
    
    var screenTitle: String {
        return L10n.news
    }
    
    var newsScreenState: Observable<ScreenState<NewsOverviewResponseDTO>> = Observable(.loading)

    private func fetch(screenState: Observable<ScreenState<NewsOverviewResponseDTO>>) {
        newsLoadTask = newsOverviewUseCase.execute(completion: { [weak self] in
            switch $0 {
            case let.success(news):
                screenState.value = .succes(data: news)
            case let .failure(error):
                screenState.value = .error(error: error.localizedDescription)
            }
        })
    }
}
