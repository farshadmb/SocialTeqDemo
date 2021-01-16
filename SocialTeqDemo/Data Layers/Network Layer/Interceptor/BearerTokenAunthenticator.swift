//
//  BearerTokenAunthenticator.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

struct BearerTokenAunthenticator: NetworkIntercaptor {
    
    let token: String
    
    var headerValue: String {
        return "Bearer \(token)"
    }
    
    init(token: String) {
        self.token = token
    }
    
    
    func adapt(_ urlRequest: URLRequest, for session: URLSession, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var outputRequest = urlRequest
        
        let authorizationHeader = outputRequest.allHTTPHeaderFields?.first(where: { $0.key == "Authorization" })
            
        guard authorizationHeader == nil else {
            if let authHeaderValue = authorizationHeader?.value, authHeaderValue != headerValue {
                inject(token: headerValue, into: &outputRequest)
            }
            
            completion(.success(outputRequest))
            return
        }
        
        inject(token: headerValue, into: &outputRequest)
    }
    
    func inject(token: String, into request: inout URLRequest) {
        request.setValue(token, forHTTPHeaderField: "Authorization")
    }
    
}
