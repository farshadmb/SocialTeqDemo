//
//  ServiceViewModel.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation
import Combine

final class ServiceViewModel: ObservableObject, Identifiable {
    
    var id: String = ""
    
    @Published var state: State = .idle
    
    var cancelBag = Set<AnyCancellable>()
    let service: Service
    
    enum State {
        case idle
        case loading
        case load(output: SimpleOutput)
        case loadedDetail(output: DetailOutput?)
        case error(String)
    }
    
    enum Event {
        case fetchingData
        case retry
        case selectPaymentMethod(atIndex: Int)
    }
    
    init(state: State = .idle, model: Category, dataService: Service) {
        self.state = state
        self.id = model.id
        self.service = dataService
        let simpleOutput = SimpleOutput(title: model.titles.en,
                                        subTitle: model.subTitles.en,
                                        description: model.shortDescriptions.en,
                                        image: model.image?.originalURL, badgeString: model.hasNewBadge ? "NEW" : "")
        self.state = .load(output: simpleOutput)
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
        
        typealias Output = AnyPublisher<CategoryDetail,Error>
        
        let output : Output = service.get(byId: "carwash")
        output.catch {[weak self] error -> AnyPublisher<Output.Output,Never> in
            self?.state = .error(error.localizedDescription)
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        .map {
            let packages = $0.data.compactMap( { value in
                DetailOutput.Package(id: value.id,
                                     title: value.titles.en,
                                     subTitle: value.subTitles.en,
                                     description: value.shortDescriptions.en,
                                     image: value.image.originalURL3X,
                                     isActive: value.isActive,
                                     hasDiscount: value.hasDiscount,
                                     discountPercentage: value.discountPercentage,
                                     isSpecial: value.isSpecial,
                                     price: value.listBasePrice,
                                     discountPrice: value.basePrice)
            })
            
            return State.loadedDetail(output: DetailOutput(title: $0.title,
                                                    description: $0.description,
                                                    image: $0.image.originalURL,
                                                    packages: packages))
        }
        .subscribe(on: DispatchQueue.main)
        .receive(on: RunLoop.main)
        .assign(to: \.state,on: self)
        .store(in: &cancelBag)
        
    }
    
}

extension ServiceViewModel {
    
    struct SimpleOutput {
        let title: String
        let subTitle: String
        let description: String
        
        let image: URL?
        let badgeString: String
        
    }
    
    struct DetailOutput {
        
        let title: String
        let description: String
        let image: URL?
        
        let packages: [Package]
        
        struct Package : Identifiable {
            let id: String
            let title: String
            let subTitle: String
            let description: String
            let image: URL?
            let isActive: Bool
            let hasDiscount: Bool
            let discountPercentage: Int
            let isSpecial: Bool
            let price: Int
            let discountPrice: Int
        }
        
    }
}
