//
//  HomeHGrid.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI
/*
struct HomeHGrid<Content: View, ViewModel: Identifiable>: View {
    
    @State var title: String
    @State var size: GridItem.Size
    @Binding var items: [ViewModel]
    
    let content: (ViewModel) -> Content
    
    init(title: String,
         size: GridItem.Size,
         items: [ViewModel],
         @ViewBuilder content: @escaping (ViewModel) -> Content) {
        self.title = title
        self.size = size
        self.items = items
        self.content = content
    }
    
    private var layout: GridItem {
        return GridItem(size, spacing: 0.0, alignment: .leading)
    }
    
    var body: some View {
        VStack {
            Text(title)
                .poppinsFont(weight: .semibold, size: 14.0)
                .foregroundColor(.grayMedium)
            
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [layout],
                          alignment: .center, spacing: 24) {
                    ForEach(items) { item in
                        content(item)
                    }
                }
                
            }
        }
    }
}
extension String: Identifiable {
    public var id: Self {
        return self
    }
}
struct HomeHGrid_Previews: PreviewProvider {
    static var previews: some View {
        HomeHGrid(title: "SERVICES",
                               size: .flexible(),
                       items: ["0","1","2","4","5"]) { item in
            Text(item)
        }
    }
}
 */
