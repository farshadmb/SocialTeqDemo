//
//  SocialTeqDemoApp.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/15/21.
//

import SwiftUI

@main
struct SocialTeqDemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel())
        }
    }
}
