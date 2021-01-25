//
//  HomeView.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/24/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
     
    @State var destinationView: AnyView? = nil
    @State var navigationTriggle: Bool = false
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var rows: [GridItem] {
        [GridItem(.adaptive(minimum: 191, maximum:191), spacing: 24.0)]
    }
    
    var body: some View {
        NavigationView {
            MakeView {
                view(for: viewModel.state)
            }
            .onAppear(perform: observerState)
            .background(Color.white)
            .navigationBarTitle(Text("Home"))
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func view(for state: HomeViewModel.State) -> AnyView {
        switch state {
        case .idle:
            return Text("idle").erase()
        case .loading:
            return ActivityIndicator(isAnimating: .constant(true),
                                     style: .medium).erase()
        case .loaded(let output):
            return ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: HomeHeaderView()) {
                        VStack(alignment: .leading) {
                            Text(output.title)
                                .poppinsFont(weight: .bold, size: 24.0)
                            Text(output.subTitle)
                                .poppinsFont(weight: .light, size: 18.0)
                        }
                        .padding(.horizontal, 24.0)
                        .padding(.vertical, 16.0)
                        
                        HomeHGrid(title: "SERVICES", layout: rows,
                                  items: .constant(output.services)) { viewModel in
                                print(viewModel, " selected")
                        } content: { (viewModel) in
                            NavigationLink(destination: ServiceDetailView(viewModel: viewModel)) {
                                ServiceItemView(viewModel: viewModel)
                            }
                        }
                        
                        HomeHGrid(title: "PROMOTION", layout: rows,
                                  items: .constant(output.promotions)) { viewModel in
                            print(viewModel," selected")
                        } content: { (viewModel) in
                            PromotionItemView(title: viewModel.output.title,
                                              descriptions: viewModel.output.subTitle,
                                              image: viewModel.output.image)
                        }
                        
                    }
                }
                .background(Color(hex: "#F9FAFF"))
            }.erase()
        case .error(let error):
            return Button(action: {
                viewModel.send(event: .retry)
            }, label: {
                Text(error).poppinsFont(weight: .medium, size: 18.0)
                    .lineLimit(10)
                    .padding(24)
            }).erase()
        }
    }
    
    func observerState() {
        switch viewModel.state {
        case .idle:
            viewModel.send(event: .load)
        default:
            break
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
        HomeView(viewModel: AppDIContainer.default.homeViewModel)
            .previewDevice("iPhone 11")
    }
}
