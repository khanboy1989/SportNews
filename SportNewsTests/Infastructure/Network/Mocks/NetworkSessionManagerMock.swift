//
//  NetworkSessionManagerMock.swift
//  SportNewsTests
//
//  Created by Serhan Khan on 30.01.23.
//

import Foundation

/**
 Mocks the NetworkSessionManager
 - parameters: response, data, error
 - returns: mocked data, response, error
 Main aim is to mock network SessionDataTask
 only returns provided data to tets classes 
 */
struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    //Mock the request for given data, response and error
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
