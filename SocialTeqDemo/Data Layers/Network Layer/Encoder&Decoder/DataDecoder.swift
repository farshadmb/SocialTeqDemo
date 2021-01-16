//
//  DataDecoder.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

protocol DataDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: DataDecoder {}
extension PropertyListDecoder: DataDecoder {}
