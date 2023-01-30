//
//  NewsOverviewViewModelTests.swift
//  SportNewsTests
//
//  Created by Serhan Khan on 30.01.23.
//

import XCTest

class NewsOverviewViewModelTests: XCTestCase {
    
    //Mock error
    private enum NewsOverViewUseCaseError: Error {
        case someError
    }
    
    //Mock Usecase
    class NewsOverviewUseCaseMock: NewsOverviewUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var newsOverView = NewsOverviewResponseDTO(type: "type", analytics: Analytics(oewa: "oewa", google: "oewa"), data: MainData(fussball: [], wintersport: [], motorsport: [], sportmix: [], esports: []))

        func execute(completion: @escaping (Result<NewsOverviewResponseDTO, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(newsOverView))
            }
            expectation?.fulfill()
            return nil
        }
    }
    
    func test_whenNewsOverviewUseCase_ReturnsDataSuccesfully_thenViewModelContainsData() {
        //given
        let newsOverviewUseCaseMock = NewsOverviewUseCaseMock()
        newsOverviewUseCaseMock.expectation = self.expectation(description: "test success case")
        newsOverviewUseCaseMock.newsOverView = NewsOverviewResponseDTO(type: "test", analytics: Analytics(oewa: "owea", google: "oewa"), data: MainData(fussball: [], wintersport: [], motorsport: [], sportmix: [], esports: []))
        let viewModel = DefaultNewsOverviewViewModel(newsOverviewUseCase: newsOverviewUseCaseMock)
        
        //when
        viewModel.fetchNewsOverview()
        
        viewModel.newsScreenState.observe(on: self, observerBlock: { result in
            switch result {
            
            case .succes(let data):
                XCTAssertNotNil(data)
            default:
                XCTFail("shoud not happen")
            }
        })
        //then
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_whenNewsOverviewUseCase_NewsDataFailed_thenUseCaseReturnsError() {
        //given
        let newsOverviewUseCaseMock = NewsOverviewUseCaseMock()
        newsOverviewUseCaseMock.expectation = self.expectation(description: "test success case")
        newsOverviewUseCaseMock.error = NewsOverViewUseCaseError.someError
        let viewModel = DefaultNewsOverviewViewModel(newsOverviewUseCase: newsOverviewUseCaseMock)
        
        //when
        viewModel.fetchNewsOverview()
        
        viewModel.newsScreenState.observe(on: self, observerBlock: { result in
            switch result {
            
            case let .error(error):
                XCTAssertNotNil(error)
            default:
                XCTFail("shoud not happen")
            }
        })
        //then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
