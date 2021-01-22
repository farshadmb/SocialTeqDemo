//
//  ImageLoaderTests.swift
//  SocialTeqDemoTests
//
//  Created by Farshad Mousalou on 1/22/21.
//

import UIKit
import Combine
import Foundation
import XCTest
@testable import SocialTeqDemo

class ImageLoaderTests: XCTestCase {
    
    var simpleNetworkService: NetworkService!
    var imageLoader: ImageLoader!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        let session = URLSession.shared
        simpleNetworkService = APIClient(session: session, operationQueue: DispatchQueue.global(qos: .utility))
        imageLoader = ImageLoader(network: simpleNetworkService, cache: ImageMemoryCache())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        simpleNetworkService = nil
        imageLoader = nil
        try super.tearDownWithError()
    }
    
    func testSimpleSuccessPNGImageLoader() throws {
        
        guard let imageLoader = imageLoader, let url = URL(string: "https://storage.googleapis.com/rafiji-staging/images/categoryImage/carwash@2x.png") else {
            throw UnitTestError()
        }
        
        let expection = self.expectation(description: "\(#function)")
        let _ = imageLoader.loadImage(from:url)
            .sink(receiveCompletion: { (error) in
                XCTFail("Image request failed: \(String(describing: error))")
            }, receiveValue: { (result) in
                XCTAssertNotNil(result, "Image is empty or meet error")
                if let _ = result {
                    expection.fulfill()
                }
            })
        
        
        wait(for: [expection], timeout: 20.0)
    }
    
    func testSimpleFailureSendRequest() throws {
        guard let imageLoader = imageLoader, let url = URL(string: "https://qwe.googleapis.com/rafiji-staging/images/categoryImage/carwash@2x.png") else {
            throw UnitTestError()
        }
        
        let expection = self.expectation(description: "\(#function)")
        let _ = imageLoader.loadImage(from:url)
            .sink(receiveCompletion: { (error) in
                print("Image request failed: \(String(describing: error))")
            }, receiveValue: { (result) in
                XCTAssertNil(result, "Image is empty or meet error")
                if let _ = result {
                    XCTFail("Image request operation did finish successfully.")
                }
                expection.fulfill()
            })
        
        
        wait(for: [expection], timeout: 20.0)
        
    }
    
}
