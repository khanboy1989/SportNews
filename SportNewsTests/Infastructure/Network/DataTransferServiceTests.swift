//
//  DataTransferServiceTests.swift
//  SportNewsTests
//
//  Created by Serhan Khan on 30.01.23.
//

import XCTest

private struct MockModel: Decodable {
    let name: String
}

class DataTransferServiceTests: XCTestCase {
    
    private enum DataTransferErrorMock: Error {
        case someError
    }
    
    func test_receivedValidJsonResponse_shouldDecodeResponse_ToObject() {
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should decode mock object")
        
        //expected mocked data
        let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
        
        //init network service
        let networkService = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                                             data: responseData,
                                                                                                             error: nil))
        //mocked model is used in order to check if network manager can decode the given response data correctly
        let endPoint = Endpoint<MockModel>(path: "https://www.laola1.at/", method: .get)
        let dataTransferService = DefaultDataTransferService(networkService: networkService)
      
        //init DefaultNetworkService from main project
        //decoding event takes place in main  DataTransferService
        _ = dataTransferService.request(with: endPoint) { result in
            //when
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }

        //then
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_receivedInvalidJsonResponse_shouldNotDecode_ToObject() {
    
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should not decode mock object")
        
        //data reponse is provided to NetworkSessionManager (on purpose wrong 'key' given) to test if the decoding fails
        let responseData = #"{"age": 20}"#.data(using: .utf8)
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: NetworkSessionManagerMock(response: nil,
                                                    data: responseData,
                                                    error: nil))
        
        //mocked model endpoint
        let endPoint = Endpoint<MockModel>(path: "https://www.laola1.at/", method: .get)
        
        //init DefaultNetworkService from main project
        let dataTransferService = DefaultDataTransferService(networkService: networkService)
        
        //when
        _ = dataTransferService.request(with: endPoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
              
                expectation.fulfill()
            }
        }
        //then
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_whenBadRequestReceived_shouldRethrowNetworkError() {
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should throw network error")
        //define invalid response and pass it to NetworkSessionManagerMock
        let responseData = #"{"invalidStructure": "Nothing"}"#.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: nil)
       
        //init DefaultNetworkService from main project
        let networkService = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: response,
                                                                                                             data: responseData,
                                                                                                             error: DataTransferErrorMock.someError))
        
        let dataTransferService = DefaultDataTransferService(networkService: networkService)
        //when
        _ = dataTransferService.request(with: Endpoint<MockModel>(path: "https://www.laola1.at/", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                //will return an exception because fails and fullfilled here
                if case DataTransferError.networkFailure(NetworkError.error(statusCode: 500, _)) = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        //then
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_whenNoDataReceived_shouldThrowNoDataError() {
        //given
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Should throw no data error")
        
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let networkService = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: response,
                                                                                                             data: nil,
                                                                                                             error: nil))
        
        let dataTransferService = DefaultDataTransferService(networkService: networkService)
        //when
        _ = dataTransferService.request(with: Endpoint<MockModel>(path: "https://www.laola1.at/", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case DataTransferError.noResponse = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        //then
        wait(for: [expectation], timeout: 0.5)
    }
    
}
