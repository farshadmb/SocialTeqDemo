//
//  HomeView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI

struct HomeView: View {
    
    //    @ObservedObject var viewModel: HomeViewModel
    //
    //    init(viewModel: HomeViewModel) {
    //        self.viewModel = viewModel
    //    }
    var rows: [GridItem] {
        [GridItem(.adaptive(minimum: 191, maximum:191), spacing: 24.0)]
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: HomeHeaderView()) {
                        VStack(alignment: .leading) {
                            Text("Book Now!")
                                .poppinsFont(weight: .bold, size: 24.0)
                            Text("You can book the desired service and get the best quality!")
                                .poppinsFont(weight: .light, size: 18.0)
                        }
                        .padding(.horizontal, 24.0)
                        .padding(.vertical, 16.0)
                        
                        Text("SERVICES")
                            .poppinsFont(weight: .semibold, size: 14.0)
                            .foregroundColor(.grayMedium)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 0)
                            .padding(.top, 16)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: self.rows, alignment: .center, spacing: 24) {
                                ForEach(1...10, id: \.self) { count in
                                    ServiceItemView(title: "Placeholder \(count)")
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 24)
                        }
                        
                        Text("PROMOTION")
                            .poppinsFont(weight: .semibold, size: 14.0)
                            .foregroundColor(.grayMedium)
                            .padding(.horizontal, 24)
                            .padding(.top, 0)
                            .padding(.top, 16)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.adaptive(minimum: 190, maximum:191), spacing: 24.0)], alignment: .center, spacing: 24) {
                                ForEach(1...10, id: \.self) { count in
                                    PromotionItemView(title: "Placeholder \(count)")
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 25.0)
                            
                        }
                    }
                }
                .background(Color(hex: "#F9FAFF"))
            }
            .background(Color.white)
            .navigationBarTitle(Text("Home"))
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    //    static let viewModel = HomeViewModel(state: .idle, dataService: HomeDataService(networkService: APIClient(session: .shared), interceptor: BearerTokenAunthenticator(token: "")))
    //
    //    static var previews: some View {
    //        HomeView(viewModel:viewModel)
    //    }
    
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 11")
    }
}
