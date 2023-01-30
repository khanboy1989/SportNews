//
//  NewsOverviewDetailsViewModelTests.swift
//  SportNewsTests
//
//  Created by Serhan Khan on 30.01.23.
//

import XCTest

//NewsOverviewDetailsViewModelTests
class NewsOverviewDetailsViewModelTests: XCTestCase {
    
    func test_TestViewModel_UrlRequest_NotNil() {
        //given
        let expectations = self.expectation(description: "test url requst is not nil")
        expectations.expectedFulfillmentCount = 2
        let viewModel = DefaultNewsOverviewDetailsViewModel(item: SportData(id: 1, title: "Test", text: "", dateString: "", url: "https://www.example.com", app: "", image: Image(small: "", medium: "", large: ""), category: Category(filterId: 1, filterTitle: "", id: 1, title: "", icon: "")))
        
        //keep global variable for url request
        //after url request completed it will be initialized
        var request: URLRequest?
        
       //when
        viewModel.urlRequest.observe(on: self, observerBlock: { urlRequst in
            request = urlRequst
            expectations.fulfill()
        })
        
        //then
        viewModel.viewDidLoad()
        wait(for: [expectations], timeout: 5)
        XCTAssertNotNil(request)
    }
}
