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
   
    // MARK: - DataSource
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
    
    @IBOutlet private weak var customSegmentsView: CustomSegmentsView!
    
    private let refreshControl = UIRefreshControl()

    // MARK: - Initializer
    init(viewModel: NewsOverviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: NewsOverviewViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIViewController Lifecycle events
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUIComponents()
        viewModel?.viewDidLoad()
    }

    //MARK: - Deinit
    deinit {
        //remove observers when the viewcontroller deinitialized
        viewModel?.newsScreenState.remove(observer: self)
        viewModel?.categorySegmentItems.remove(observer: self)
    }
    
    /*
     Binds the viewmodel input events
     */
    override func bindViewModel() {
        super.bindViewModel()
        title = viewModel?.screenTitle
    }

    //MARK: - Methods
    override func executeRequests() {
        super.executeRequests()
        viewModel?.fetchNewsOverview()
    }

    //MARK: - ConfigureObservers
    /*
     Binds the viewmodel output events
     */
    override func configureObservers() {
        viewModel?.newsScreenState.observe(on: self) { [weak self] in
            switch $0 {
            case let.succes(data):
                LoadingView.hide()
                self?.updateNewOverviews(items: data)
                self?.refreshControl.endRefreshing()
            case .loading:
                LoadingView.show()
                self?.refreshControl.endRefreshing()
            case let .error(error):
                self?.showAlert(message: error)
                LoadingView.hide()
                self?.refreshControl.endRefreshing()
            case .finished:
                printIfDebug("finished")
                break
            case .noData:
                LoadingView.hide()
                printIfDebug("no data")
                break
            }
        }
        viewModel?.categorySegmentItems.observe(on: self) {[weak self] items in
            self?.customSegmentsView.setItems(items: items)
        }
    }
    
    //binds the custom view click events to viewcontroller
    //from here it we are interacting with viewModel(if applicable)
    private func bindUIComponents() {
        self.customSegmentsView.onWillChangeSelectedItem = {[weak self] selectedItem in
            self?.viewModel?.onCategoryItemChange(selectedItem)
        }
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    //Updates the newsoverview tableview cell depending on the received full data
    private func updateNewOverviews(items: [DefaultNewsOverviewViewModel.Section: [NewOverviewViewModel]]) {
        var snapshot = NSDiffableDataSourceSnapshot<DefaultNewsOverviewViewModel.Section, NewOverviewViewModel>()
        
        //create sections and sort then depending on order
        let sections = items.keys.map({ sectionItem -> DefaultNewsOverviewViewModel.Section in
            return sectionItem
        }).sorted(by: { $0.order < $1.order })
        
        //append sections
        snapshot.appendSections(sections)
        
        //append items for sections depending or order
        sections.forEach { sectionItem in
            snapshot.appendItems(items[sectionItem] ?? [], toSection: sectionItem)
        }
        
        //apply new changes to tableview
        tableViewDataSource.apply(snapshot, animatingDifferences: true, completion: {
            //after completion reload data
            self.tableView.reloadData()
        })
    }
    
    //MARK: - END of Methods
    
    // MARK: - TableviewCell Provider
    private func newOverviewTableViewCellProvider(tableView: UITableView, indexPath: IndexPath , item: NewOverviewViewModel) -> UITableViewCell? {
        return NewOverviewTableViewCell.create(tableView: tableView, item: item)
    }

    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        self.viewModel?.fetchNewsOverview()
        self.viewModel?.onCategoryItemChange(.all)
    }

}

//MARK: - UITableViewDelegate
extension NewsOverviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.backgroundColor = Asset.Colors.lightGray.color
        header.textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemIdentifier = tableViewDataSource.itemIdentifier(for: indexPath) else {
            self.showAlert(message: L10n.selectedItemError)
             return
        }
        //when clicked show detail of selected item
        self.viewModel?.showDetails(sportData: itemIdentifier.item)
    }
}

// MARK: - NewsOverviewTableViewDataSource
class NewsOverviewTableViewDataSource: UITableViewDiffableDataSource<DefaultNewsOverviewViewModel.Section,NewOverviewViewModel> {
    //return the titles for tableview sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.snapshot().sectionIdentifiers[section]
        return section.title
    }
}
