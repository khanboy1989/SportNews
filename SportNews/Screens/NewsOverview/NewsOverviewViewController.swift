//
//  NewsOverviewViewController.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation
import UIKit

final class NewsOverviewViewController: BaseViewController {
    
    // MARK: - ViewModel
    private let viewModel: NewsOverviewViewModel?
   
    private lazy var tableViewDataSource = NewsOverviewTableViewDataSource(tableView: tableView, cellProvider: newOverviewTableViewCellProvider)
    
    // MARK: - UI Elements
    @IBOutlet weak private var tableView: UITableView! {
        willSet {
            newValue.tableFooterView = UIView()
            newValue.delegate = self
            newValue.contentInsetAdjustmentBehavior = .never
            newValue.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        }
    }
    
    // MARK: - DataSource
    
    // MARK: - Initializer
    init(viewModel: NewsOverviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: NewsOverviewViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        title = viewModel?.screenTitle
    }
    
    //MARK: - Methods
    override func executeRequests() {
        super.executeRequests()
        viewModel?.fetchNewsOverview()
    }
    
    override func configureObservers() {
        viewModel?.newsScreenState.observe(on: self) { [weak self] in
            switch $0 {
            case let.succes(data):
                LoadingView.hide()
                self?.updateNewOverviews(items: data)
            case .loading:
                LoadingView.show()
            case let .error(error):
                self?.showAlert(message: error)
            case .finished:
                printIfDebug("finished")
                break
            case .noData:
                LoadingView.hide()
                printIfDebug("no data")
                break
            }
        }
    }
    
    //Updates the newsoverview tableview cell depending on the received full data
    private func updateNewOverviews(items: [DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]) {
        var snapshot = NSDiffableDataSourceSnapshot<DefaultNewsOverviewViewModel.Section, NewOverviewViewModel>()
        snapshot.appendSections([.fussball, .wintersport, .motorsport, .sportmix, .esports])
        snapshot.appendItems(items[.fussball] ?? [], toSection: .fussball)
        snapshot.appendItems(items[.wintersport] ?? [], toSection: .wintersport)
        snapshot.appendItems(items[.motorsport] ?? [], toSection: .motorsport)
        snapshot.appendItems(items[.sportmix] ?? [], toSection: .sportmix)
        snapshot.appendItems(items[.esports] ?? [], toSection: .esports)
        tableViewDataSource.apply(snapshot, animatingDifferences: true,completion: self.tableView.reloadData)
    }
    //MARK: - END of Methods
    
    // MARK: - TableviewCell Provider
    private func newOverviewTableViewCellProvider(tableView: UITableView, indexPath: IndexPath , item: NewOverviewViewModel) -> UITableViewCell? {
        return NewOverviewTableViewCell.create(tableView: tableView, item: item)
    }
}

extension NewsOverviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 16)
        header.textLabel?.textColor = UIColor.black
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - NewsOverviewTableViewDataSource
class NewsOverviewTableViewDataSource: UITableViewDiffableDataSource<DefaultNewsOverviewViewModel.Section,NewOverviewViewModel> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.snapshot().sectionIdentifiers[section]
        return section.rawValue
    }
}