//
//  MakeView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI

struct MakeView: View {
    let make: () -> AnyView

    var body: some View {
        make()
    }
}

extension View {
    func erase() -> AnyView {
        AnyView(self)
    }
}
