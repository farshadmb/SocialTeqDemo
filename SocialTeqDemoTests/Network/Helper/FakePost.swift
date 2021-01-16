//
//  FakePost.swift
//  SocialTeqDemoTests
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

typealias FakePosts = [FakePost]

struct FakePost: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
