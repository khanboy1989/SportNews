//
//  NewsOverviewDetailsViewModel.swift
//  SportNews
//
//  Created by Serhan Khan on 29.01.23.
//

import Foundation

protocol NewsOverviewDetailsInputViewModel {
    func viewWillAppear()
    func viewDidLoad()
}

protocol NewsOverviewDetailsOutputViewModel {
    var screenTitle: Observable<String> { get }
    var urlRequest: Observable<URLRequest?> { get }
}

protocol NewsOverviewDetailsViewModel: NewsOverviewDetailsInputViewModel, NewsOverviewDetailsOutputViewModel {}

final class DefaultNewsOverviewDetailsViewModel: NewsOverviewDetailsViewModel {
    
    var screenTitle: Observable<String> = Observable("")
    var urlRequest: Observable<URLRequest?> = Observable(nil)
    
    private let item: SportData
    
    init(item: SportData) {
        self.item = item
    }
    
    func viewWillAppear() {
        screenTitle.value = self.item.title
    }
    
    func viewDidLoad() {
        if let url = URL(string: item.url) {
            urlRequest.value = URLRequest(url: url)
        } else {
            urlRequest.value = nil 
        }
    }
    
}
