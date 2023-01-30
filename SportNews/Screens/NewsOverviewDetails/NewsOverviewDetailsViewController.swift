//
//  NewsOverviewDetailsViewController.swift
//  SportNews
//
//  Created by Serhan Khan on 29.01.23.
//

import Foundation
import UIKit
import WebKit

final class NewsOverviewDetailsViewController: BaseViewController {
    
    //MARK: - ViewModel
    private let viewModel: NewsOverviewDetailsViewModel?
    
    //MARK: - UI Elements
    @IBOutlet private weak var webView: WKWebView! {
        willSet {
            newValue.backgroundColor = Asset.Colors.appBackgroundColor.color
            newValue.navigationDelegate = self
        }
    }
    
    @IBOutlet private weak var tryAgainButton: UIButton! {
        willSet{
            newValue.isHidden = true
        }
    }

    //MARK: - Initializer
    init(viewModel: NewsOverviewDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: NewsOverviewDetailsViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
        webView.isHidden = false
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    //MARK: - configureObservers
    override func configureObservers() {
        super.configureObservers()
        viewModel?.screenTitle
           .observe(on: self) { [weak self] title in
            //init the title for selected item
           self?.title = title
       }
        viewModel?.urlRequest
            .observe(on: self) { [weak self] urlRequest in
                guard let urlRequest = urlRequest else { return }
                LoadingView.show()
                self?.webView.load(urlRequest)
        }
    }
    
    //MARK: - Try Again Button
    /*
     When there is a network error user will have chance to
     try again for better UX
     */
    @IBAction func tryAgainButtonTapped(sender: UIButton) {
        viewModel?.didFailTryAgain()
        self.tryAgainButton.isHidden = true
        self.webView.isHidden = true
        LoadingView.show()
    }
}

extension NewsOverviewDetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingView.hide()
        self.webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        LoadingView.hide()
        self.webView.isHidden = false
        self.tryAgainButton.isHidden = false
        self.showAlert(message: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        LoadingView.hide()
        self.webView.isHidden = false
        self.tryAgainButton.isHidden = false
        self.showAlert(message: error.localizedDescription)
    }
}
