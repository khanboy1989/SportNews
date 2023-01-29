//
//  NewsOverviewViewModel.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

struct NewsOverviewViewModelActions {
    let showDetails: (SportData) -> Void
}

protocol NewsOverviewInputViewModel {
    func showDetails(sportData: SportData)
    func fetchNewsOverview()
}

protocol NewsOverviewOutputViewModel {
    var screenTitle: String { get }
    var newsScreenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>> { get }
}

struct NewOverviewViewModel {
    let type: String
    let item: SportData
}

extension NewOverviewViewModel: Hashable {
    static func == (lhs: NewOverviewViewModel, rhs: NewOverviewViewModel) -> Bool {
        return lhs.item == rhs.item
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(item)
    }
}

protocol NewsOverviewViewModel: NewsOverviewInputViewModel, NewsOverviewOutputViewModel { }

final class DefaultNewsOverviewViewModel: NewsOverviewViewModel {
    
    enum Section: String, CaseIterable {
        case fussball = "Fussball"
        case wintersport = "Winter Sport"
        case motorsport = "Motor Sport"
        case sportmix = "Sport Mix"
        case esports = "Esports"
        
        var title: String {
            switch self {
            case .fussball:
                return L10n.football
            case .wintersport:
                return L10n.winterSport
            case .motorsport:
                return L10n.motorsport
            case .sportmix:
                return L10n.sportmix
            case .esports:
                return L10n.esports
            }
        }
    }
    
    private let newsOverviewUseCase: NewsOverviewUseCase
    private let actions: NewsOverviewViewModelActions?
    private var newsLoadTask: Cancellable? { willSet { newsLoadTask?.cancel() } }
   
    init(newsOverviewUseCase: NewsOverviewUseCase,
         actions: NewsOverviewViewModelActions? = nil ) {
        self.newsOverviewUseCase = newsOverviewUseCase
        self.actions = actions
    }
    
    func showDetails(sportData: SportData) {
        actions?.showDetails(sportData)
    }
    
    func fetchNewsOverview() {
        fetch(screenState: newsScreenState)
    }
    
    var screenTitle: String {
        return L10n.news
    }
    
    var newsScreenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>> = Observable(.loading)

    private func fetch(screenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>>) {
        newsLoadTask = newsOverviewUseCase.execute(completion: { [weak self] in
            switch $0 {
            case let.success(news):
                self?.createSections(screenState: screenState, news: news)
            case let .failure(error):
                screenState.value = .error(error: error.localizedDescription)
            }
        })
    }
    
    private func createSections(screenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>>, news: NewsOverviewResponseDTO) {
        var items: [Section: [NewOverviewViewModel]] = [:]
        
        let fussball = news.data.fussball.sorted(by: {$0.data.date! > $1.data.date! }).map{ item -> NewOverviewViewModel in
            return NewOverviewViewModel(type: item.type, item: item.data)
        }
        
        let wintersport = news.data.wintersport.sorted(by: {$0.data.date! > $1.data.date! })
            .map { item -> NewOverviewViewModel in
                return NewOverviewViewModel(type: item.type, item: item.data)}
        
        let motorsport = news.data.motorsport.sorted(by: {$0.data.date! > $1.data.date!}).map { item -> NewOverviewViewModel in
            return NewOverviewViewModel(type: item.type, item: item.data)}
        
        let sportmix = news.data.sportmix.sorted(by: {$0.data.date! > $1.data.date!}).map { item -> NewOverviewViewModel in
            return NewOverviewViewModel(type: item.type, item: item.data)}
        
        let esports = news.data.esports.sorted(by: {$0.data.date! > $1.data.date!}).map { item -> NewOverviewViewModel in
            return NewOverviewViewModel(type: item.type, item: item.data)}
        
        items[.fussball] = fussball
        items[.wintersport] = wintersport
        items[.motorsport] = motorsport
        items[.sportmix] = sportmix
        items[.esports] = esports
        
        screenState.value = .succes(data: items)
        
    }
}
