//
//  CategoryService.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import Foundation

struct CategoryDataService: Service {
    
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
    
    func get<T>(byId id : String) -> Output<T> where T: Decodable {
        return Output<T>.create { (observer) -> Disposable in
            let request = APIRequest(url:"https://api-dot-rafiji-staging.appspot.com/customer/v2/categories/" + id + "/services", method: .get)
            let task = self.networkService.send(request: request,
                                     decoder: self.decoder,
                                     interceptor: self.interceptor) { (result: Result<T,Error>) in
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
        }
        .eraseToAnyPublisher()
    }
    
}
