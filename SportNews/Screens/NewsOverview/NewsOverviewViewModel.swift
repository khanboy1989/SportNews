//
//  NewsOverviewViewModel.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

//Actions that are necessary from the ViewController to ViewModel
//NOTE: Actions are initialized and handled inside the
//NewsOverviewFlowCoordinator
struct NewsOverviewViewModelActions {
    let showDetails: (SportData) -> Void
}

//INPUT: receives the orders (click event, request events from the view controller)
protocol NewsOverviewInputViewModel {
    func showDetails(sportData: SportData)
    func fetchNewsOverview()
    func viewDidLoad()
    func onCategoryItemChange(_ selectedItem: DefaultNewsOverviewViewModel.Section)
}

//OUTPUT: sends the events to viewcontroller
protocol NewsOverviewOutputViewModel {
    var screenTitle: String { get }
    var newsScreenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>> { get }
    var categorySegmentItems: Observable<[CustomSegmentItem]> { get }
}

//NesOverviewModel struct is to map real DTO that is received from the UseCase
//to viewcontroller
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
    
    //MARK: - Section
    enum Section: String, CaseIterable {
        case all = "All"
        case fussball = "Fussball"
        case wintersport = "Winter Sport"
        case motorsport = "Motor Sport"
        case sportmix = "Sport Mix"
        case esports = "Esports"
        
        var title: String {
            switch self {
            case .all:
                return L10n.segmentAll
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
        
        var order: Int {
            switch self {
            case .all:
                return 0
            case .fussball:
                return 1
            case .wintersport:
                return 2
            case .motorsport:
                return 3
            case .sportmix:
                return 4
            case .esports:
                return 5
            }
        }
    }
    
    //MARK: - Parameters
    private let newsOverviewUseCase: NewsOverviewUseCase
    private let actions: NewsOverviewViewModelActions?
    private var newsLoadTask: Cancellable? { willSet { newsLoadTask?.cancel() } }
    private var allNewsItems: [DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]] = [:]
    private var selectedCategoryItem: Section = .all
    
    //MARK: - Init
    init(newsOverviewUseCase: NewsOverviewUseCase,
         actions: NewsOverviewViewModelActions? = nil ) {
        self.newsOverviewUseCase = newsOverviewUseCase
        self.actions = actions
    }
    
    //MARK: - ShowDetails
    /**
        Receives the click event from the viewcontroller and shows the details
        Note: the navigation event is handled inside the Coordinator which is in this case
        NewsOverviewFlowCoordinator
     */
    func showDetails(sportData: SportData) {
        actions?.showDetails(sportData)
    }
    
    //MARK: - FetchNewOverview
    //expecting call from viewcontroller
    func fetchNewsOverview() {
        fetch(screenState: newsScreenState)
    }
    
    //returns the title of the screen
    var screenTitle: String {
        return L10n.news
    }
    
    //MARK: - ViewDidLoad
    //When view is loaded before awaiting the call to be completed
    //creates the segment items manually
    //TODO: Make the segment creation depending on API call result
    func viewDidLoad() {
        self.createCategorySegmentItems(categorySegmentItems: categorySegmentItems)
    }
    
    //MARK: - OnSelected Item Changed
    func onCategoryItemChange(_ selectedItem: DefaultNewsOverviewViewModel.Section) {
        guard  let selectedCategoryItem = DefaultNewsOverviewViewModel.Section.allCases.first(where: { $0 == selectedItem }) else {
            return
        }
        //create header segment items depending on selection
        //by default it is all selected
        self.createCategorySegmentItems(selectedItem: selectedCategoryItem,categorySegmentItems: categorySegmentItems)
        //keep the selected category as default
        self.selectedCategoryItem = selectedCategoryItem
        //prepare the sections depending on selection
        self.createSections(for: selectedCategoryItem)
    }
    
    //OUTPUT observable with screen state that handles when the loading spinner will be shown and when the data is arrived
    var newsScreenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>> = Observable(.loading)
    
    var categorySegmentItems: Observable<[CustomSegmentItem]> = Observable([])

    // MARK: - Fetch the News
    private func fetch(screenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>>) {
        newsLoadTask = newsOverviewUseCase.execute(completion: { [weak self] in
            switch $0 {
            case let.success(news):
                self?.preapareRawData(screenState: screenState, news: news)
            case .failure(_):
                screenState.value = .error(error: L10n.defaultError)
            }
        })
    }
    
    //MARK: - Create Sections
    /**
        Creates the data for viewcontroller that needs to be displayed
     */
    private func preapareRawData(screenState: Observable<ScreenState<[DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]>>, news: NewsOverviewResponseDTO) {
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
        
        allNewsItems = items
        createSections(for: selectedCategoryItem)
    }
    
    //MARK: - CreateCategorySegmentItems
    private func createCategorySegmentItems(selectedItem: DefaultNewsOverviewViewModel.Section = .all ,categorySegmentItems: Observable<[CustomSegmentItem]>) {
        
        let segmentItems: [CustomSegmentItem] = DefaultNewsOverviewViewModel.Section.allCases.map({ sectionItem -> CustomSegmentItem in
        
            if sectionItem == selectedItem {
                return CustomSegmentItem(title: sectionItem.title, isSelected: true, type: sectionItem)
            } else {
                return CustomSegmentItem(title: sectionItem.title, isSelected: false, type: sectionItem)
            }
        })
        categorySegmentItems.value = segmentItems
    }
    
    private func createSections(for selectedCategory: DefaultNewsOverviewViewModel.Section) {
        switch selectedCategory {
        case .all:
            newsScreenState.value = .succes(data: allNewsItems)
        default:
            guard let newData = allNewsItems[selectedCategory] else { return }
            newsScreenState.value = .succes(data: [selectedCategory : newData])
        }
    }
}
