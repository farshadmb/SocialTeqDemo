//
//  Image+ImageLoader.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/26/21.
//

import Foundation
import SwiftUI
import Combine

extension Image {
    
    func fetchingRemoteImage(from url: URL?) -> some View {
        return ModifiedContent(content: self, modifier: RemoteImageModifier(url: url, loader: AppDIContainer.imageLoader))
    }
}

struct RemoteImageModifier: ViewModifier {
    let url: URL?
    let loader: ImageLoader
    
    @State private var fetchedImage: UIImage? = nil

    @State private var disposeBag = Set<AnyCancellable>()
    
    func body(content: Content) -> some View {
        if let image = fetchedImage {
            return Image(uiImage: image)
                .resizable()
                .eraseToAnyView()
        }

        return content
            .onAppear(perform: fetch)
            .eraseToAnyView()
    }

    private func fetch() {
        guard let url = self.url else { return }
        loader.loadImage(from: url)
            .assign(to: \.fetchedImage, on: self)
            .store(in: &disposeBag)
    }
    
}

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
