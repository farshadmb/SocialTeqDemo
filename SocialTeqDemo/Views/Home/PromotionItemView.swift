//
//  PromotionItemView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import Foundation
import SwiftUI

struct PromotionItemView: View {
    
    @State var title: String = "Time to TRAVEL!"
    @State var descriptions: String = "If you want to travel, this is best opportunity!"
    @State var image: URL? = nil
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image("Airplane")
                .resizable()
                .fetchingRemoteImage(from: image)
                .aspectRatio(contentMode: .fit)
                .clipped()
            
            VStack(alignment: .leading, spacing: 10.0){
                Text(title)
                    .poppinsFont(weight: .semibold, size: 18.0)
                    .foregroundColor(.lightBlue2)
                    .lineLimit(3)
                    .frame(maxWidth: 75)
                Text(descriptions)
                    .poppinsFont(weight: .light, size: 12.0)
                    .foregroundColor(.lightBlue2)
                    .frame(maxWidth: 181)
                    .lineLimit(3)
                
            }.padding()
        }
        .background(Color.lightBlue2)
        .cornerRadius(16)
        .clipped()
        .frame(maxWidth: 330, maxHeight: 140)
        
        
    }
}

struct PromotionItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            PromotionItemView()
        }
    }
}
