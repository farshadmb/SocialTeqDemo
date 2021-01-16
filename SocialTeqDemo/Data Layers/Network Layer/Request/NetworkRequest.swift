//
//  NetworkRequest.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

protocol NetworkURLRequestConvertible {
    func asURL() throws -> URL
}

protocol NetworkRequestConvertiable {
    
    func asURLRequest() throws -> URLRequest
}

extension String: NetworkURLRequestConvertible {
  
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NSError() }

        return url
    }
}

extension URL: NetworkURLRequestConvertible {
   
    public func asURL() throws -> URL { self }
}

extension URLRequest: NetworkRequestConvertiable {
    
    func asURLRequest() throws -> URLRequest { self }
}

extension URLRequest {
   
    init(url: NetworkURLRequestConvertible,
                method: HTTPMethod, headers: [String: String]? = nil) throws {
        let url = try url.asURL()

        self.init(url: url)

        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
}
