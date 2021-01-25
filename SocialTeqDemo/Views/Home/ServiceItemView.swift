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
    @State var badge: String = ""
    @State var hasBadge: Bool = false
    @State var image: URL? = nil
    
    @ObservedObject var viewModel: ServiceViewModel
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 10.0) {
                HStack(alignment: .top) {
                    Image("large")
                        .resizable()
                        .fetchingRemoteImage(from: image)
                        .frame(width: 58, height: 50)
                    
                    Spacer(minLength: 24.0)
                    if hasBadge {
                        TextBadgeView(text: badge, color: .redColor)
                    }else {
                        EmptyView()
                    }
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
        .onAppear(perform: observeState)
        
    }
    
    private func observeState() {
        switch viewModel.state {
        case .load(output: let output):
            title = output.title
            descriptions = output.subTitle
            extraInfo = output.description
            badge = output.badgeString
            hasBadge = !badge.isEmpty
            image = output.image
            
        default:
            return
        }
    }
}

struct ServiceItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            
        }
    }
}
