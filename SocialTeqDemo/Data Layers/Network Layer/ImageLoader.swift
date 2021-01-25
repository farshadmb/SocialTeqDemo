//
//  ImageLoader.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation
import Combine
import UIKit

final class ImageLoader {
    
    private let cache: ImageMemoryCache
    private let network: NetworkService
    
    
    init(network: NetworkService, cache: ImageMemoryCache) {
        self.network = network
        self.cache = cache
    }
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        
        let publisher = AnyPublisher<UIImage?, Error>.create {[weak self] observer in
            guard let strongSelf = self else {
                observer.onComplete()
                return Disposable(dispose: {
                    
                })
            }
            
            let loadTask = strongSelf.network.download(request: url) { (result) in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data, scale: UIScreen.main.scale)
                    observer.onNext(image)
                    observer.onComplete()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposable {
                loadTask?.cancel()
            }
        }
        
        return publisher.catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .subscribe(on: DispatchQueue.main)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
