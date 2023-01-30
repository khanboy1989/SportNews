//
//  NewsOverviewUseCaseTests.swift
//  SportNewsTests
//
//  Created by Serhan Khan on 30.01.23.
//

import XCTest

/*
 NewsOverviewUseCaseTests repository is mocked and tested with a mocked way
 testing UseCases makes more if we have local database (persistent) implemented
 in that case we can see if the save functions are called
 */
class NewsOverviewUseCaseTests: XCTestCase {
    
    //Mock error
    private enum NewsOverviewRepositoryError: Error {
        case someError
    }
    
    //mock NewsOverviewRepository
    class NewsOverviewRepositoryMock: NewsOverViewRepository {
        var expectation: XCTestExpectation?
        var error: Error?
        var newsOverView = NewsOverviewResponseDTO(type: "", analytics: Analytics(oewa: "", google: ""), data: MainData(fussball: [], wintersport: [], motorsport: [], sportmix: [], esports: []))
        
        func fetchNewsOverview(completion: @escaping (Result<NewsOverviewResponseDTO, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(newsOverView))
            }
            expectation?.fulfill()
            return nil
        }
    }
    
    func test_whenNewsOverviewRepository_ReturnsDataSuccesfully() {
        //given
        let newsOverviewRepositoryMock = NewsOverviewRepositoryMock()
        newsOverviewRepositoryMock.expectation = self.expectation(description: "test success case")
        newsOverviewRepositoryMock.newsOverView = NewsOverviewResponseDTO(type: "", analytics: Analytics(oewa: "oewa", google: "oewa"), data: MainData(fussball: [], wintersport: [], motorsport: [], sportmix: [], esports: []))
        let newsOverviewUseCase = DefaultNewsOverviewUseCase(newsOverviewRepository: newsOverviewRepositoryMock)
        
        //when
        newsOverviewUseCase.execute(completion: { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
            default:
                XCTFail("shoud not happen")
            }
        })
        
        //then
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_whenNewsOverviewRepository_FailureCase() {
        //given
        let newsOverviewRepositoryMock = NewsOverviewRepositoryMock()
        newsOverviewRepositoryMock.expectation = self.expectation(description: "test success case")
        newsOverviewRepositoryMock.error = NewsOverviewRepositoryError.someError
        let newsOverviewUseCase = DefaultNewsOverviewUseCase(newsOverviewRepository: newsOverviewRepositoryMock)
        
        //when
        newsOverviewUseCase.execute(completion: { result in
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
            default:
                XCTFail("shoud not happen")
            }
        })
        
        //then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
