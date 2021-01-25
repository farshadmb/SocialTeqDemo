//
//  Color+Extension.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Color {
    
    static let grayMedium = Color(hex: "#727991")
    static let grayBlack = Color(hex: "#08143C")
    static let grayRegular = Color(hex: "#D1D4DC")
    static let grayLight = Color(hex: "#F0F1F5")
    static let mainColorPrimary = Color(hex: "#103AC1")
    static let redColor = Color(hex: "#FC3D39")
    static let lightBlue = Color(hex: "#E6EBFA")
    static let redBlack = Color(hex: "#FB2F5F")
    static let otherBlue = Color(hex: "#22C8EF")
    static let lightBlue2 = Color(hex: "#3E96AC")

    static let viewBackground = Color(hex: "#E5E5E5")
    
    struct TabBar {
        static let inactiveTabBar = Color.grayMedium
        static let activeTabBar = Color.mainColorPrimary
    }
    
    struct Alert {
        static let error = Color.redColor
    }
    
    struct Shadow {
        static let fourPercent = Color.black.opacity(0.04)
        static let eightPercent = Color.black.opacity(0.08)
        
    }
    
}
