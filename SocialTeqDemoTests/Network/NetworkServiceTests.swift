//
//  NetworkServiceTests.swift
//  SocialTeqDemoTests
//
//  Created by Farshad Mousalou on 1/16/21.
//

import XCTest
import Foundation
@testable import SocialTeqDemo

class MockNetworkService: NetworkService {
    
    var isExecuteSend = false
    var isExecuteDownload = false
    
    @discardableResult
    func send<T>(request: NetworkRequestConvertiable, decoder: DataDecoder, completion: @escaping ResultCompletion<T>) -> NetworkTask? where T : Decodable {
        isExecuteSend = true
        return nil
    }
    
    @discardableResult
    func download(request: NetworkRequestConvertiable, completion: @escaping ResultCompletion<Data>) -> NetworkTask? {
        isExecuteDownload = true
        return nil
    }
    
}
class NetworkServiceTests: XCTestCase {

    var mockService: MockNetworkService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockNetworkService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockService = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSendRequest() throws {
        
        guard let mockService = mockService else {
            throw UnitTestError()
        }
        
        mockService.send(request: try URLRequest(url: "test", method: .get),
                         decoder: JSONDecoder(), completion: { (a: Result<String,Error>) in })
        XCTAssertTrue(mockService.isExecuteSend)
    }
    
    func testDownloadRequest() throws {
        guard let mockService = mockService else {
            throw UnitTestError()
        }
        
        mockService.download(request: try URLRequest(url: "test", method: .get)) { (result) in
            
        }
        
        XCTAssertTrue(mockService.isExecuteDownload)
    }

}
