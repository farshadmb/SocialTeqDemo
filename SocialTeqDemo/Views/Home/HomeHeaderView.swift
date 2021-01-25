//
//  HomeHeaderView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import SwiftUI

struct HomeHeaderView: View {
    
    @State var fullName: String = "Mitchell Cooper"
    @State var greetingMsg: String = "Hello,"
    @State var alertMessage: String = "Set Your Address"
    @State var alertImage = #imageLiteral(resourceName: "Avatar")
    
    var body: some View {
        CardView(radius: 24.0, corners: [.bottomLeft, .bottomRight],
                 shadowRadius: 24.0, shadowPoint: CGPoint(x: 0, y: 6), padding: 0.0) {
            VStack(alignment: .leading, spacing: 8.0){
                // User Greeting Message UI
                HStack {
                    Image(uiImage: #imageLiteral(resourceName: "Hello hand"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 49.5, height: 49.5)
                        .clipped()
                    
                    VStack(alignment:.leading) {
                        Text(fullName).poppinsFont(weight: .semibold, size: 18)
                            .foregroundColor(.grayBlack)
                        Text(greetingMsg)
                            .poppinsFont(weight: .light, size: 18.0)
                            .foregroundColor(.grayBlack)
                    }
                    Spacer(minLength: 8.0)
                    Image(uiImage: #imageLiteral(resourceName: "Avatar"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 49.5, height: 49.5)
                        .clipped()
                }
                .padding(.horizontal, 24.0)
                .padding(.top, 30)
                .padding(.bottom, 16)
                // SeperatorView
                Rectangle().foregroundColor(.grayLight)
                    .frame(height: 1)
                // AlertMessageView
                HStack {
                    Image(uiImage: #imageLiteral(resourceName: "map-pin"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24.0, height: 24.0)
                        .clipped()
                    Text(alertMessage)
                        .poppinsFont(weight: .light, size: 14.0)
                        .frame(alignment: .topLeading)
                        .lineSpacing(19.60)
                    Spacer(minLength: 8.0)
                    Image(uiImage: #imageLiteral(resourceName: "chevron-down"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24.0, height: 24.0)
                        .clipped()
                    
                }
                .padding(.horizontal, 24.0)
                .padding(.vertical, 8.0)
            }
            .padding(.bottom, 8.0)
        }
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
