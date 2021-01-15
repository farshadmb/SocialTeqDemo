//
//  CategoryDetail.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/15/21.
//

import Foundation

struct CategoryDetail: Codable {
    let slug, title: String
    let image: CategoryImage
    let slogan, description: String
    let data: [Datum]
}



struct ExtraNoteField: Codable {
    let isEnable: Bool
    let id, title, placeholder: String

    enum CodingKeys: String, CodingKey {
        case isEnable
        case id = "id"
        case title, placeholder
    }
}


struct Scheduling: Codable {
    let scheduleTitles: Descriptions
    let hasReturnDate: Bool
    let id, scheduleTitle, returnDateTitle: String

    enum CodingKeys: String, CodingKey {
        case scheduleTitles, hasReturnDate
        case scheduleTitle
        case id = "id"
        case returnDateTitle
    }
}

struct Datum: Codable {
    let titles, subTitles, shortDescriptions: Descriptions
    let isActive: Bool
    let sort: Int
    let isSpecial: Bool
    let id, slug, coverImageID, categoryID: String
    let basePrice, listBasePrice: Int
    let coverImage: CoverImage
    let image: CategoryImage
    let title, subTitle, shortDescription: String
    let hasDiscount: Bool
    let discountPercentage: Int
    let description, selectItemsModalDescription: String

    enum CodingKeys: String, CodingKey {
        case titles, subTitles, shortDescriptions, isActive, sort, isSpecial
        case id = "id"
        case slug
        case coverImageID = "coverImageId"
        case categoryID = "categoryId"
        case basePrice, listBasePrice, coverImage, image, title, subTitle, shortDescription, hasDiscount, discountPercentage
        case description, selectItemsModalDescription
    }
}

struct CoverImage: Codable {
    let id, path, fileName, type: String
    let thumbnails: Thumbnails
    let createdAt, updatedAt: String
    let v: Int
    let serviceID, originalURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case path, fileName, type, thumbnails, createdAt, updatedAt
        case v = "__v"
        case serviceID = "serviceId"
        case originalURL = "originalUrl"
    }
}

struct Thumbnails: Codable {
    
    let has128x128, has256x256, has512x512: Bool

    enum CodingKeys: String, CodingKey {
        case has128x128 = "has128x128"
        case has256x256 = "has256x256"
        case has512x512 = "has512x512"
    }
}
