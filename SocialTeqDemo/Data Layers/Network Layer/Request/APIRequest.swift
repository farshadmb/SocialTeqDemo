//
//  APIRequest.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

struct APIRequest : NetworkRequestConvertiable {
    
    let method: HTTPMethod
    let body: Data?
    let query: String?
    let url: NetworkURLRequestConvertible
    
    init(url: NetworkURLRequestConvertible, method: HTTPMethod, body: Data?, query: String?) {
        self.url = url
        self.method = method
        self.body = body
        self.query = query
    }
    
    func asURLRequest() throws -> URLRequest {
        return try URLRequest(url:url, method: self.method, headers: nil)
    }
}
