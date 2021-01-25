//
//  CardView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI

struct CardView<ContentView: View>: View {
    
    let cornerRadius: CGFloat
    let cornersEdge: UIRectCorner
    let contentBuilder: () -> ContentView
    let shadowRadius: CGFloat
    let shadowPoint: CGPoint
    let padding : CGFloat
    
    init(radius: CGFloat = 12.0,
         corners: UIRectCorner = .allCorners,
         shadowRadius: CGFloat = 16, shadowPoint: CGPoint = .init(x: 0, y: 4),
         padding: CGFloat = 16.0,
         @ViewBuilder builder: @escaping () -> ContentView) {
        contentBuilder = builder
        cornerRadius = radius
        cornersEdge = corners
        self.shadowRadius = shadowRadius
        self.shadowPoint = shadowPoint
        self.padding = padding
    }
    
    var body: some View {
        Group {
            contentBuilder()
        }
        .padding(padding)
        .background(Color.white)
        .cornerRadius(cornerRadius, corners: cornersEdge)
        .shadow(color: Color.Shadow.eightPercent, radius: self.shadowRadius, x: shadowPoint.x, y: shadowPoint.y)
        
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack(spacing: 25.0) {
            CardView(radius: 16.0, corners: [.bottomRight,.bottomLeft]) {
                Text("Hello World").poppinsFont(weight: .bold)
            }
            
            CardView(radius: 5.0, corners: [.topLeft,.bottomRight]) {
                Text("Hello World").poppinsFont(weight: .bold)
            }
        }
    }
}
