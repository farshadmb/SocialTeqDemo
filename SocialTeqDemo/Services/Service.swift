//
//  Service.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import Foundation
import Combine

protocol Service {
    
    typealias Output<T> = AnyPublisher<T, Error>
    
    func fetchAll<T: Decodable>() -> Output<[T]>
    
    func get<T: Decodable>() -> Output<T>
    
    func get<T: Decodable>(byId: String) -> Output<T>
    
}

// default implementation
extension Service {
    
    func fetchAll<T: Decodable>() -> Output<[T]> {
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    func get<T: Decodable>() -> Output<T> {
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    func get<T: Decodable>(byId: String) -> Output<T> {
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
}
