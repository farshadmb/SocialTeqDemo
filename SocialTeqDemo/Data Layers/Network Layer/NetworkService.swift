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
    
    typealias NetworkTask = URLSessionTask
    
    /// <#Description#>
    /// - Parameters:
    ///   - request: <#request description#>
    ///   - decoder: <#decoder description#>
    ///   - completion: <#completion description#>
    @discardableResult
    func send<T: Decodable>(request: NetworkRequestConvertiable, decoder: DataDecoder, completion: @escaping ResultCompletion<T>) -> NetworkTask?
    
    /// <#Description#>
    /// - Parameters:
    ///   - request: <#request description#>
    ///   - completion: <#completion description#>
    @discardableResult
    func download(request: NetworkRequestConvertiable, completion: @escaping ResultCompletion<Data>) -> NetworkTask?
    
}

//Abstract
protocol NetworkServiceInterceptorable: NetworkService {
    
    /// <#Description#>
    /// - Parameters:
    ///   - request: <#request description#>
    ///   - decoder: <#decoder description#>
    ///   - interceptor: <#interceptor description#>
    ///   - completion: <#completion description#>
    @discardableResult
    func send<T: Decodable>(request: NetworkRequestConvertiable,
                            decoder: DataDecoder,
                            interceptor: NetworkIntercaptor,
                            completion: @escaping ResultCompletion<T>) -> NetworkTask?
    /// <#Description#>
    /// - Parameters:
    ///   - request: <#request description#>
    ///   - interceptor: <#interceptor description#>
    ///   - completion: <#completion description#>
    @discardableResult
    func download(request: NetworkRequestConvertiable,
                  interceptor: NetworkIntercaptor,
                  completion: @escaping ResultCompletion<Data>) -> NetworkTask?
    
}
