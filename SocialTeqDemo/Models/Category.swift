//
//  Category.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/15/21.
//

import Foundation

struct Category: Codable {
    
    let titles, subTitles, descriptions, shortDescriptions: Descriptions
    let slogans: Descriptions
    let isActive: Bool
    let sort: Int
    let hasNewBadge: Bool
    let id, slug, displayType, title: String
    let subTitle, description, shortDescription, slogan: String
    let image: CategoryImage?
    let searchPlaceholder, skipHint, skipButtonLabel: String
    let serviceDetailsPrimaryActionLabel, bookingFormPrimaryActionLabel: String

    enum CodingKeys: String, CodingKey {
        case titles, subTitles, descriptions, shortDescriptions, slogans, isActive, sort, hasNewBadge
        case id = "id"
        case slug, displayType, title, subTitle, description, shortDescription, slogan, image
        case searchPlaceholder, skipHint, skipButtonLabel, serviceDetailsPrimaryActionLabel, bookingFormPrimaryActionLabel
    }
}

struct CategoryImage: Codable {
    let originalURL, originalURL2X, originalURL3X, originalURL4X: URL?
    let originalURLPDF, originalURLSVG: URL?

    enum CodingKeys: String, CodingKey {
        case originalURL = "originalUrl"
        case originalURL2X = "originalUrl@2x"
        case originalURL3X = "originalUrl@3x"
        case originalURL4X = "originalUrl@4x"
        case originalURLPDF = "originalUrlPDF"
        case originalURLSVG = "originalUrlSVG"
    }
}

struct Descriptions: Codable {
    let en, ar: String
}
