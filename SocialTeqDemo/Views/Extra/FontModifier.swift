//
//  FontModifier.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation
import SwiftUI

struct PoppinsFontModifier: ViewModifier {
    
    var weight =  Font.Weight.regular
    var size : CGFloat =  14.0
    
    let name = "Poppins-Regular"
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(name, size: size)
            .weight(weight))
    }
    
}

extension View {
    
    func poppinsFont(weight: Font.Weight, size: CGFloat = 14.0) -> some View {
        self.modifier(PoppinsFontModifier(weight: weight, size: size))
    }
}
