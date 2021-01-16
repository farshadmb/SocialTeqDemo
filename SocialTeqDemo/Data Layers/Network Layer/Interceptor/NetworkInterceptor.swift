//
//  NetworkInterceptor.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

protocol NetworkIntercaptor {
    
    func adapt(_ urlRequest: URLRequest, for session: URLSession, completion: @escaping (Result<URLRequest, Error>) -> Void)
    
}

extension NetworkIntercaptor {
    func adapt(_ urlRequest: URLRequest, for session: URLSession, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
}
