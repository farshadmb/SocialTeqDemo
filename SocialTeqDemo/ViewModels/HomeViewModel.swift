//
//  HomeViewModel.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject, Identifiable {
    
    @Published var state: State = .idle
    
    var cancelBag = Set<AnyCancellable>()
    let service: Service
    
    deinit {
        
    }
    
    enum State {
        case idle
        case loading
        case loaded(output: Output)
        case error(String)
    }
    
    enum Event {
        case load
        case retry
        case selectService(atIndex: Int)
        case selectPromotion(atIndex: Int)
        case select(item: Any)
    }
    
    let diContainer: AppDIContainer
    
    init(state: State = .idle, dataService: Service, container: AppDIContainer) {
        self.state = state
        self.service = dataService
        self.diContainer = container
    }
    
    func send(event: Event) {
        
        switch event {
        case .load, .retry:
            state = .loading
            fetchHomeData()
        case .select(item: let itemSelected):
            print(itemSelected)
        case .selectService(atIndex:let index):
            print(index)
            break
        case .selectPromotion(atIndex:let index):
            print(index)
            break
        }
        
    }
    
    
    private func fetchHomeData() {
        
        typealias Output = AnyPublisher<HomeModel,Error>
        
        let output : Output = service.get()
        output.catch {[weak self] error -> AnyPublisher<HomeModel, Never> in
            self?.state = .error(error.localizedDescription)
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        .map { value in
            let output = HomeViewModel.Output(title: value.title,
                                              subTitle: value.subTitle,
                                              services: (value.categories ?? []).compactMap { ServiceViewModel(state: .idle,
                                                                                                                    model: $0,
                                                                                                                    dataService: type(of: self.diContainer).serviceDataService) },
                                              promotions: (value.promotions ?? []).map { PromotionViewModel(model: $0) })
            return State.loaded(output: output)
        }
        .subscribe(on: DispatchQueue.main)
        .receive(on: RunLoop.main)
        .assign(to: \.state,on: self)
        .store(in: &cancelBag)
        
        
    }
    
}

extension HomeViewModel {
    
    struct Output {
        let title: String
        let subTitle: String
        let services: [ServiceViewModel]
        let promotions: [PromotionViewModel]
    }
    
}
