//
//  ServiceViewModel.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation
import Combine

final class ServiceViewModel: ObservableObject {
    
    @Published var state: State = .idle
    
    var cancelBag = Set<AnyCancellable>()
    let service: Service
    
    enum State {
        case idle
        case loading
        case loaded(output: Any?)
        case error(String)
    }
    
    enum Event {
        case fetchingData
        case retry
        case selectPaymentMethod(atIndex: Int)
    }
    
    init(state: State = .idle, dataService: Service) {
        self.state = state
        self.service = dataService
    }
    
    func send(event: Event) {
        
        switch event {
        case .fetchingData, .retry:
            state = .loading
            fetchData()
        case .selectPaymentMethod(atIndex: let index):
            print(index)
        }
        
    }
    
    
    private func fetchData() {
        
        typealias Output = AnyPublisher<Category?,Error>
        
        let output : Output = service.get(byId: "carwash")
        output.catch {[weak self] error -> AnyPublisher<Output.Output,Never> in
            self?.state = .error(error.localizedDescription)
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        .map { _ in State.loaded(output: nil) }
        .subscribe(on: DispatchQueue.main)
        .receive(on: RunLoop.main)
        .assign(to: \.state,on: self)
        .store(in: &cancelBag)
        
    }
    
}
