//
//  NetworkInterceptor.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

protocol NetworkIntercaptor {
    
    /// <#Description#>
    /// - Parameters:
    ///   - urlRequest: <#urlRequest description#>
    ///   - session: <#session description#>
    ///   - completion: <#completion description#>
    func adapt(_ urlRequest: URLRequest, for session: URLSession) -> Result<URLRequest, Error>
    
}

extension NetworkIntercaptor {
    
    func adapt(_ urlRequest: URLRequest, for session: URLSession) -> Result<URLRequest, Error> {
        return .success(urlRequest)
    }
}
