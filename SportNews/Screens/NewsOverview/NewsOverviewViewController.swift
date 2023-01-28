//
//  NewsOverviewViewController.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

final class NewsOverviewViewController: BaseViewController {
    
    private let viewModel: NewsOverviewViewModel!
    
    init(viewModel: NewsOverviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: NewsOverviewViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func executeRequests() {
        super.executeRequests()
        viewModel.fetchNewsOverview()
    }
    
    override func configureObservers() {
        viewModel.newsScreenState.observe(on: self) { [weak self] in
            switch $0 {
            case let.succes(data):
                printIfDebug("data===> \(data)")
            case .loading:
                break
            case let .error(error):
                printIfDebug("error =\(error)")
                self?.showAlert(message: error)
            case .finished:
                printIfDebug("finished")
                break
            case .noData:
                printIfDebug("no data")
                break
            }
        }
    }
}
