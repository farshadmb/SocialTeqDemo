//
//  Cache.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation

protocol Cache {
    
    associatedtype Value
    associatedtype Key: Hashable
    
    func set(value: Value?, forKey: Key)
    
    func value(forKey key: Key) -> Value?
    
    func removeAllValue()
    
    subscript(_ key: Key) -> Value? { get set }
}
