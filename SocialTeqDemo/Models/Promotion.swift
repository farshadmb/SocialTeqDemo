//
//  Promotion.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/15/21.
//

import Foundation

struct Promotion: Codable {
    let image: PromotionImage
}

struct PromotionImage: Codable {
    let originalURL: URL?

    enum CodingKeys: String, CodingKey {
        case originalURL = "originalUrl"
    }
}
