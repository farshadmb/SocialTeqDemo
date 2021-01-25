//
//  SocialTeqDemoApp.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/15/21.
//

import SwiftUI

@main
struct SocialTeqDemoApp: App {
    
    init() {
        let font = UIFont(name: "Poppins-SemiBold", size: 18.0)!
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font, .foregroundColor : UIColor(Color.grayBlack)]
        UINavigationBar.appearance().titleTextAttributes = [.font : font, .foregroundColor : UIColor(Color.grayBlack)]
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "arrow-left")?.withRenderingMode(.alwaysTemplate)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel())
        }
    }
}
