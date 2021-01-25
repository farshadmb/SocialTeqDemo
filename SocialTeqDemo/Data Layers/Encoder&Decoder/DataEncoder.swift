//
//  DataEncoder.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

protocol DataEncoder: Encoder {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}


