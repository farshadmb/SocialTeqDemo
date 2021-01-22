//
//  ImageMemoryCache.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation
import UIKit

class ImageMemoryCache: Cache {
    
    struct Config {
        let countLimit: Int
        let memoryLimit: Int
        
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }
    
    typealias Value = UIImage
    typealias Key = URL
    
    private lazy var storage: NSCache<AnyObject, Value> = {
        let cache = NSCache<AnyObject, Value>()
        cache.countLimit = config.countLimit
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config
    
    init(config: Config = .defaultConfig) {
        self.config = config
    }
    
    func set(value: UIImage?, forKey key: URL) {
        insertImage(value, for: key)
    }
    
    func value(forKey key: URL) -> UIImage? {
        
        lock.lock(); defer { lock.unlock() }
        // the best case scenario -> there is a decoded image
        guard let image = storage.object(forKey: key as AnyObject) else {
            return nil
        }
        
        return image
    }
    
    func removeAllValue() {
        lock.lock(); defer { lock.unlock() }
        storage.removeAllObjects()
    }
    
    subscript(key: URL) -> UIImage? {
        get {
            value(forKey: key)
        }
        set (image){
            set(value: image, forKey: key)
        }
    }
    
    // MARK: - Private Methods
    
    
    private func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        
        lock.lock(); defer { lock.unlock() }
        storage.setObject(image, forKey: url as AnyObject)
        
    }
    
    private func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        storage.removeObject(forKey: url as AnyObject)
    }
    
    
}
