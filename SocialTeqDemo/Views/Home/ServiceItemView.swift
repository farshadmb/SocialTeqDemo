//
//  ServiceItemView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import Foundation
import SwiftUI

struct ServiceItemView: View {
    
    @State var title: String = "Carwash"
    @State var descriptions: String = "Carwash"
    @State var extraInfo: String = "Basic | Eco | Pro | VIP"
    @State var color = Color.Alert.error
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 10.0) {
                HStack(alignment: .top) {
                    Image("large")
                        .resizable()
                        .frame(width: 58, height: 50)
                    Spacer(minLength: 24.0)
                    TextBadgeView(text: "NEW", color: .redColor)
                }
                Spacer(minLength: 28.0)
                VStack(alignment: .leading) {
                    Text(title)
                        .lineSpacing(25.20)
                        .lineLimit(1)
                        .frame(alignment: .topLeading)
                        .poppinsFont(weight: .semibold, size: 18.0)
                        .foregroundColor(.grayBlack)
                    
                    Text(descriptions)
                        .fontWeight(.semibold)
                        .font(.caption)
                        .frame(alignment: .topLeading)
                        .lineSpacing(16.80)
                        .lineLimit(2)
                        .poppinsFont(weight: .semibold, size: 12.0)
                        .foregroundColor(.grayBlack)
                }
                Text(extraInfo)
                    .italic()
                    .frame(alignment:.topLeading)
                    .lineSpacing(19.20)
                    .lineLimit(1)
                    .poppinsFont(weight: .regular, size: 12.0)
                    .foregroundColor(.grayMedium)
            }
        }
        .frame(maxWidth: 171, maxHeight: 190)
        
        
    }
}

struct ServiceItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            ServiceItemView()
        }
    }
}
