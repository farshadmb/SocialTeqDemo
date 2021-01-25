//
//  TextBadgeView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import Foundation
import SwiftUI

struct TextBadgeView: View {
    @State var text: String = "%20"
    @State var color = Color.Alert.error
    
    var body: some View {
        Text(text)
            .poppinsFont(weight: .semibold, size: 12.0)
            .lineSpacing(16.80)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(color)
            .cornerRadius(10)
            .foregroundColor(.white)
        
    }
}

struct TextBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            TextBadgeView()
        }
    }
}
