//
//  APIClientTests.swift
//  SocialTeqDemoTests
//
//  Created by Farshad Mousalou on 1/16/21.
//

import XCTest
import Foundation
@testable import SocialTeqDemo

class APIClientTests: XCTestCase {
    
    var simpleNetworkService: NetworkService!
    
    var authenticatiedService: NetworkServiceInterceptorable!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        let session = URLSession.shared
        simpleNetworkService = APIClient(session: session, operationQueue: DispatchQueue.global(qos: .utility))
        authenticatiedService = APIClient(session: session, operationQueue: DispatchQueue.global(qos: .background))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        simpleNetworkService = nil
        authenticatiedService = nil
        try super.tearDownWithError()
    }
    
    func testSimpleSuccessSendRequest() throws {
        guard let mockService = simpleNetworkService else {
            throw UnitTestError()
        }
        let expection = self.expectation(description: "\(#function)")
        
        mockService.send(request: try URLRequest(url: "https://jsonplaceholder.typicode.com/posts", method: .get),
                         decoder: JSONDecoder()) { (result: Result<FakePosts,Error>) in
            switch result {
            case .success(let posts):
                print(posts)
                expection.fulfill()
            case .failure(let error):
                XCTFail("\(error): \(error.localizedDescription)")
            }
        }
        wait(for: [expection], timeout: 20.0)
    }
    
    func testSimpleFailureSendRequest() throws {
        guard let mockService = simpleNetworkService else {
            throw UnitTestError()
        }
        
        let expection = self.expectation(description: "\(#function) testSimpleFailureSendRequest")
        
        mockService.send(request: try URLRequest(url: "https://jsonplaceholder.typicode.com/posts/1/comments", method: .get),
                         decoder: JSONDecoder()) { (result: Result<FakePost,Error>) in
            print("\(#function) \(#line)")
            switch result {
            case .success(_):
                XCTFail("The result should not has any output")
            case .failure(let error):
                print(error)
                
            }
            expection.fulfill()
        }
        
        wait(for: [expection], timeout: 50.0)
        
    }
    
    func testAuthenticatedSucessSendRequest() throws {
        guard let mockService = authenticatiedService else {
            throw UnitTestError()
        }
        
        let expection = self.expectation(description: "\(#function)")
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmZjNWM2YzFjNjU3NDAwMGJkOThlYjciLCJpYXQiOjE2MTAzNzQyNTN9.fitW1STDlJ0v87vLEzSPwENxLlP8FeYBRYEzdDX0LTU"
        
        mockService.send(request: try URLRequest(url: "https://api-dot-rafiji-staging.appspot.com/customer/v2/home", method: .get),
                         decoder: JSONDecoder(),
                         interceptor: BearerTokenAunthenticator(token: token)) { (result: Result<HomeModel,Error>) in
            switch result {
            case .success(let posts):
                print(posts)
                expection.fulfill()
            case .failure(let error):
                XCTFail("\(error): \(error.localizedDescription)")
            }
        }
        
        wait(for: [expection], timeout: 20.0)
        
    }
    
    func testAuthenticatedFailureSendRequest() throws {
        guard let mockService = authenticatiedService else {
            throw UnitTestError()
        }
        
        let expection = self.expectation(description: "\(#function)")
        let token = "expiredToken"
        
        mockService.send(request: try URLRequest(url: "https://api-dot-rafiji-staging.appspot.com/customer/v2/home", method: .get),
                         decoder: JSONDecoder(),
                         interceptor: BearerTokenAunthenticator(token: token)) { (result: Result<HomeModel,Error>) in
            switch result {
            case .success(_):
                XCTFail("The result should not has any output")
                expection.fulfill()
            case .failure(let error):
                print(error)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 20.0)
        
    }
    
}
