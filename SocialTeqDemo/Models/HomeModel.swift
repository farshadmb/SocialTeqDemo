//
//  HomeModel.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/15/21.
//

import Foundation

struct HomeModel: Codable {
    
    let title, subTitle: String
    let categories: [Category]?
    let promotions: [Promotion]?
}
