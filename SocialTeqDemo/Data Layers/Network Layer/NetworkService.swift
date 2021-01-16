//
//  NetworkService.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

//Abstract
protocol NetworkService {
    
    typealias ResultCompletion<T> = (_ result: Result<T,Error>) -> ()
    
    func send<T: Decodable>(request: NetworkRequestConvertiable, decoder: DataDecoder, completion: @escaping ResultCompletion<T>)
    
    func download(request: NetworkRequestConvertiable, completion: @escaping ResultCompletion<Data>)
    
}

//Abstract
protocol NetworkServiceInterceptorable: NetworkService {
    
    func send<T: Decodable>(request: NetworkRequestConvertiable,
                            decoder: DataDecoder,
                            interceptor: NetworkIntercaptor,
                            completion: @escaping ResultCompletion<T>)
    
    func download(request: NetworkRequestConvertiable,
                  interceptor: NetworkIntercaptor,
                  completion: @escaping ResultCompletion<Data>)
    
}
