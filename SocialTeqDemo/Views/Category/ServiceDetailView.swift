//
//  ServiceDetailView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import SwiftUI

struct ServiceDetailView: View {
    
    @ObservedObject var viewModel: ServiceViewModel
    @State var title: String = "Service"
    
    var layouts: [GridItem] {
        [GridItem(.adaptive(minimum: 209, maximum: 209), spacing: 24.0),
         GridItem(.adaptive(minimum: 209, maximum:.infinity), spacing: 24.0)]
    }
    
    var body: some View {
        
        MakeView {
            switch viewModel.state {
            case .idle,.load(output: _):
                return Text("").erase()
            case .loading:
                return ActivityIndicator(isAnimating: .constant(true),
                                         style: .medium)
                    .padding()
                    .erase()
            case .error(let error):
                return Button(action: {
                    viewModel.send(event: .retry)
                }, label: {
                    Text(error).poppinsFont(weight: .medium, size: 18.0)
                        .lineLimit(10)
                        .padding(24)
                }).erase()
            case .loadedDetail(let output) :
                guard let output = output else { return Text("").erase() }
                return ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                        VStack(alignment: .leading) {
                            Image(uiImage: #imageLiteral(resourceName: "Avatar"))
                                .resizable()
                                .fetchingRemoteImage(from: output.image)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 104, height: 100, alignment: .topLeading)
                                .clipped()
                            
                            Text(output.title)
                                .poppinsFont(weight: .bold, size: 24.0)
                                .foregroundColor(.grayBlack)
                            
                            Text(output.description)
                                .poppinsFont(weight: .light, size: 18.0)
                                .foregroundColor(.grayMedium)
                        }
                        .padding(.horizontal, 24.0)
                        .padding(.vertical, 16.0)
                        
                        LazyVGrid(columns: layouts, alignment:.leading, spacing:24.0) {
                            ForEach(output.packages) { item in
                                ServicePaymentView(title: item.title,
                                                   descriptions: item.subTitle,
                                                   extraInfo: item.description,
                                                   image: item.image,
                                                   price: "\(item.price) QAR",
                                                   discountedPercent: item.hasDiscount ? "%\(item.discountPercentage)" : "",
                                                   discountedPrice: item.hasDiscount ? "\(item.discountPrice) QAR" : "",
                                                   color: item.isSpecial ? .grayBlack : .grayLight)
                            }
                        }
                        .padding()
                    }
                    .background(Color(hex: "#F9FAFF"))
                }
                .erase()
            }
        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(hex: "#F9FAFF"))
        .onAppear(perform:{
            observerState()
            viewModel.send(event: .fetchingData)
        })
        .navigationBarHidden(false)
        .navigationBarTitle(Text(title)
                            , displayMode: .inline)
        .background(Color.white)
        
    }
    
    
    func observerState() {
        switch viewModel.state {
        case .load(output: let simple):
            title = simple.title
        default:
            break
        }
    }
    
    
}

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
