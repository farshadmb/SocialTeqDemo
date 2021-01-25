//
//  PromotionViewModel.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/25/21.
//

import Foundation

final class PromotionViewModel: ObservableObject, Identifiable {
    
    @Published var output: Output
    
    init(model: Promotion) {
        self.output = Output(title: "", subTitle: "", image: model.image.originalURL)
    }
    
}

extension PromotionViewModel {
    struct Output {
        let title: String
        let subTitle: String
        let image: URL?
    }
}
