//
//  AppDIContainer.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import Foundation

final class AppDIContainer {
    
    static var `default` : AppDIContainer = {
        AppDIContainer()
    }()
    
    static let networkService: NetworkService = {
        return APIClient(session: .shared,
                         operationQueue: .main)
    }()
    
    static let adaptedNetworkService: NetworkServiceInterceptorable = {
        return APIClient(session: .shared,
                         operationQueue: .main)
    }()
    
    static let imageLoader: ImageLoader = {
        ImageLoader(network: networkService, cache: ImageMemoryCache(config: .defaultConfig))
    }()
    
    static let interceptor: NetworkIntercaptor = {
        return BearerTokenAunthenticator(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmZjNWM2YzFjNjU3NDAwMGJkOThlYjciLCJpYXQiOjE2MTAzNzQyNTN9.fitW1STDlJ0v87vLEzSPwENxLlP8FeYBRYEzdDX0LTU")
    }()
    
    static let homeDataService: Service = {
        return HomeDataService(networkService: adaptedNetworkService,
                               interceptor: interceptor,
                               decoder: JSONDecoder())
    }()
    
    static let serviceDataService: Service = {
        return CategoryDataService(networkService: adaptedNetworkService,
                                   interceptor: interceptor,
                                   decoder: JSONDecoder())
    }()
    
    lazy var rootViewModel: RootViewModel = {
        RootViewModel(container: self)
    }()
    
    
    lazy var homeViewModel: HomeViewModel = {
        HomeViewModel(state: .idle, dataService: Self.homeDataService, container: self)
    }()
    
    
    init() {
        
    }
    
}
