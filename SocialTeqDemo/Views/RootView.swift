//
//  RootView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
    @State var current = 0
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        self.current = 0
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $current){
                HomeView()
                    .tag(0)
                Text("Category")
                    .tag(1)
                Text("Account")
                    .tag(2)
                Text("QA")
                    .tag(3)
            }
            .padding(.bottom, 45.0)
            Spacer(minLength: 1)
                .foregroundColor(.black)
            
            HStack(spacing: 0){
                TabButton(title: "Home", image: "home-tab", index: 0, selected: $current)
                Spacer(minLength: 0)
                TabButton(title: "Category", image: "category-tab", index: 1, selected: $current)
                Spacer(minLength: 0)
                TabButton(title: "Account", image: "account-tab", index: 2, selected: $current)
                Spacer(minLength: 0)
                TabButton(title: "QA", image: "qa-tab", index: 3, selected: $current)
            }
            .padding(.horizontal, 45)
            .background(Color.white)
            .cornerRadius(0.0)
            .shadow(color: Color.black.opacity(0.1), radius: 24, x: 0, y: -8.0)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView(viewModel: RootViewModel())
            RootView(viewModel: RootViewModel())
                .previewDevice("iPhone 11")
        }
    }
}
