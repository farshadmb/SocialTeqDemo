//
//  ServicePaymentView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import SwiftUI

struct ServicePaymentView: View {
    
    @State var title: String = "Carwash"
    @State var descriptions: String = "Carwash"
    @State var extraInfo: String = "Basic | Eco | Pro | VIP"
    @State var image: URL? = nil
    @State var price: String = "40.00 QAR"
    @State var discountedPercent: String = "%20"
    @State var discountedPrice: String = "49.00 QAR"
    @State var color = Color.grayLight
    
    var body: some View {
        CardView(radius: 16.0,
                 shadowRadius: 0, padding: 16.0,
                 backgroundColor:color) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image("large")
                        .resizable()
                        .fetchingRemoteImage(from: image)
                        .frame(width: 40, height: 40)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                    
                    Spacer(minLength: 24.0)
                    if discountedPercent.isEmpty == false {
                        TextBadgeView(text: discountedPercent, color: .redColor)
                    }else {
                        EmptyView()
                    }
                }
                Spacer(minLength: 12.0)
                VStack(alignment: .leading, spacing: 2.0) {
                    Text(title)
                        .lineLimit(1)
                        .poppinsFont(weight: .semibold, size: 18.0)
                        .foregroundColor(color != .grayLight ? .white : .grayBlack)
                    Text(descriptions)
                        .font(.caption)
                        .lineLimit(1)
                        .poppinsFont(weight: .semibold, size: 12.0)
                        .foregroundColor(color != .grayLight ? .white : .grayBlack)
                    Text(extraInfo)
                        .italic()
                        .lineLimit(2)
                        .poppinsFont(weight: .regular, size: 12.0)
                        .foregroundColor(color != .grayLight ? .white : .grayMedium)
                }
                Spacer(minLength: 15.0)
                HStack(alignment: .center) {
                    
                    Text(discountedPrice.isEmpty ? price : discountedPrice)
                        .lineLimit(1)
                        .poppinsFont(weight: .semibold, size: 14.0)
                        .foregroundColor(.otherBlue)
                    Spacer(minLength: 1)
                    
                    if discountedPrice.isEmpty == false {
                        Text(price)
                            .strikethrough()
                            .lineLimit(1)
                            .poppinsFont(weight: .semibold, size: 10.0)
                            .foregroundColor(.redColor)
                    }else {
                        EmptyView()
                    }
                }
            }
        }
        .frame(maxWidth: 171, maxHeight: 209)
        
    }
}

struct ServicePaymentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            ServicePaymentView(title: "Basic",
                               descriptions: "Simple & Quick",
                               extraInfo: "Exterior",
                               price: "19.00 QAR",
                               discountedPercent: "", discountedPrice:"")
            
            ServicePaymentView(title: "Eco", descriptions: "Efficient & Economical", extraInfo: "Quick exterior steam wash", price: "49.00 QAR", discountedPercent: "%20", discountedPrice:"40.00 QAR")
            
            ServicePaymentView(title: "Basic",
                               descriptions: "Simple & Quick",
                               extraInfo: "Exterior",
                               price: "19.00 QAR",
                               discountedPercent: "",
                               discountedPrice:"", color: Color(hex: "#103AC1"))
        }
    }
}
