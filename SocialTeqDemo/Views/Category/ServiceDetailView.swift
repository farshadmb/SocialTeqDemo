//
//  ServiceDetailView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import SwiftUI

struct ServiceDetailView: View {
    
    var layouts: [GridItem] {
        [GridItem(.adaptive(minimum: 191, maximum:191), spacing: 24.0),
         GridItem(.adaptive(minimum: 191, maximum:191), spacing: 24.0)]
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                    
                    VStack(alignment: .leading) {
                        Image(uiImage: #imageLiteral(resourceName: "large"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 104, height: 100, alignment: .topLeading)
                            .clipped()
                        
                        Text("Book Now!")
                            .poppinsFont(weight: .bold, size: 24.0)
                            .foregroundColor(.grayBlack)
                        
                        Text("You can book the desired service and get the best quality!")
                            .poppinsFont(weight: .light, size: 18.0)
                            .foregroundColor(.grayMedium)
                    }
                    .padding(.horizontal, 24.0)
                    .padding(.vertical, 16.0)
                    
                    LazyVGrid(columns: layouts, alignment:.leading, spacing:24.0) {
                        ForEach(0...3,id:\.self) { _ in
                            ServicePaymentView(title: "Basic", descriptions: "Simple & Quick", extraInfo: "Exterior wash")
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle(Text("Carwash")
                                    , displayMode: .inline)
            .background(Color.white)
        }
    }
}

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView()
    }
}
