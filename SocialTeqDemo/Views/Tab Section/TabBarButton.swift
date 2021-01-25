//
//  TabBarButton.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI
struct TabButton: View {
    
    var title: String
    var image: String
    var index: Int
    
    @Binding var selected : Int
    
    private var iconSize : CGFloat {
        return index == selected ? 30 : 25
    }
    
    private var color: Color {
        return index == selected ? Color.TabBar.activeTabBar : Color.TabBar.inactiveTabBar
    }
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){ selected = index }
        }) {
            
            HStack(spacing: 10){
                
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    
                if index == selected {
                    Text(title)
                        .poppinsFont(weight: .semibold)
                        .foregroundColor(Color.TabBar.activeTabBar)
                }
            }
            .padding(10)
        }
        .foregroundColor(color)
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "Messages", image: "home-tab", index: 1, selected: .constant(0))
        TabButton(title: "Messages", image: "category-tab", index: 1, selected: .constant(0))
    }
}
