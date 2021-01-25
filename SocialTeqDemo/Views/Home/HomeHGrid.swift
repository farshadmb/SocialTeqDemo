//
//  HomeHGrid.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI

struct HomeHGrid<Content: View, ViewModel: Identifiable>: View {
    
    @State var title: String
    @State var layout: [GridItem]
    @Binding var items: [ViewModel]
    let action: (ViewModel) -> ()
    let content: (ViewModel) -> Content
    
    
    var body: some View {
        Text(title)
            .poppinsFont(weight: .semibold, size: 14.0)
            .foregroundColor(.grayMedium)
            .padding(.horizontal, 24)
            .padding(.bottom, 0)
            .padding(.top, 16)
        
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHGrid(rows: layout,
                      alignment: .center, spacing: 24) {
                ForEach(items) { item in
                    content(item)
                        .onTapGesture(count: 1, perform: { action(item) })
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
        }
    }
}

