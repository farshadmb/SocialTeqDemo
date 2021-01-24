//
//  HomeDataService.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import Foundation
import Combine

struct HomeDataService: Service {
    
    let networkService: NetworkServiceInterceptorable
    let interceptor: NetworkIntercaptor
    let decoder: DataDecoder
    
    init(networkService: NetworkServiceInterceptorable,
         interceptor: NetworkIntercaptor,
         decoder: DataDecoder = JSONDecoder()) {
        
        self.networkService = networkService
        self.interceptor = interceptor
        self.decoder = decoder
    }
    
    func fetchAll<T>() -> Output<[T]> where T : Decodable {
        
        return AnyPublisher<[T],Error>.create { (observer) -> Disposable in
            let request = APIRequest(url:"https://api-dot-rafiji-staging.appspot.com/customer/v2/home", method: .get)
            let task = self.networkService.send(request: request,
                                     decoder: self.decoder,
                                     interceptor: self.interceptor) { (result: Result<[T],Error>) in
                switch result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onComplete()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposable {
                task?.cancel()
            }
        }.eraseToAnyPublisher()
    }    
    
}
