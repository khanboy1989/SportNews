//
//  NewsOverviewDetailsViewModel.swift
//  SportNews
//
//  Created by Serhan Khan on 29.01.23.
//

import Foundation

//INPUT: receives the orders (click event, request events from the view controller)
protocol NewsOverviewDetailsInputViewModel {
    func viewWillAppear()
    func viewDidLoad()
}

//OUTPUT: sends the events to viewcontroller
protocol NewsOverviewDetailsOutputViewModel {
    var screenTitle: Observable<String> { get }
    var urlRequest: Observable<URLRequest?> { get }
}

protocol NewsOverviewDetailsViewModel: NewsOverviewDetailsInputViewModel, NewsOverviewDetailsOutputViewModel {}

final class DefaultNewsOverviewDetailsViewModel: NewsOverviewDetailsViewModel {
    
    //MARK: - Observable parameters
    var screenTitle: Observable<String> = Observable("")
    var urlRequest: Observable<URLRequest?> = Observable(nil)
    
    //MARK: - Params
    private let item: SportData
    
    //MARK: - Initializer
    init(item: SportData) {
        self.item = item
    }
    
    //MARK: - ViewWillAppear
    func viewWillAppear() {
        //When the screen is attached send the data title
        screenTitle.value = self.item.title
    }
    
    //MARK: - ViewDidLoad
    func viewDidLoad() {
        //when view did loaded send the URLRequest parameter to the screen so that WebView can load the main details for a selected item of sport data
        if let url = URL(string: item.url) {
            urlRequest.value = URLRequest(url: url)
        } else {
            urlRequest.value = nil 
        }
    }
    
}
