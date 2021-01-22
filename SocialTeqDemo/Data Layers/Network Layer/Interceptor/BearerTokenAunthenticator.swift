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
    
    
    func adapt(_ urlRequest: URLRequest, for session: URLSession) -> Result<URLRequest, Error> {
        var outputRequest = urlRequest
        
        let authorizationHeader = outputRequest.allHTTPHeaderFields?.first(where: { $0.key == "Authorization" })
            
        guard authorizationHeader == nil else {
            if let authHeaderValue = authorizationHeader?.value, authHeaderValue != headerValue {
                inject(token: headerValue, into: &outputRequest)
            }
            
            return .success(outputRequest)
            
        }
        
        inject(token: headerValue, into: &outputRequest)
        return .success(outputRequest)
    }
    
    func inject(token: String, into request: inout URLRequest) {
        request.setValue(token, forHTTPHeaderField: "Authorization")
    }
    
}
