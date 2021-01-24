//
//  HomeViewModel.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var state: State = .idle
    
    var cancelBag = Set<AnyCancellable>()
    let service: Service
    
    deinit {
        
    }
    
    enum State {
        case idle
        case loading
        case loaded(output: Any)
        case error(String)
    }
    
    enum Event {
        case load
        case retry
        case selectService(atIndex: Int)
        case selectPromotion(atIndex: Int)
        case select(item: Any)
    }
    
    init(state: State = .idle, dataService: Service) {
        self.state = state
        self.service = dataService
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
        
        typealias Output = AnyPublisher<[HomeModel],Error>
        
        let output : Output = service.fetchAll()
        output.catch {[weak self] error -> AnyPublisher<[HomeModel], Never> in
            self?.state = .error(error.localizedDescription)
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        .map { _ in State.loaded(output: [ServiceViewModel]()) }
        .subscribe(on: DispatchQueue.main)
        .receive(on: RunLoop.main)
        .assign(to: \.state,on: self)
        .store(in: &cancelBag)
        
        
    }
    
}
