//
//  ImageCache.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

protocol ImageCacheProtocol {
    // Returns the image associated with a given url
    func image(for url: URL) -> UIImage?
    
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    
    // Removes the image of the specified url in the cache
    func removeImage(for url: URL)
    
    // Removes all images from the cache
    func removeAllImages()
}

final class ImageCache: ImageCacheProtocol {
    
    // MARK: - Private properties

    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
        return cache
    }()
    private let lock = NSLock()
    
    // MARK: - ImageCacheProtocol
    
    func image(for url: URL) -> UIImage? {
        
        lock.lock(); defer { lock.unlock() }
        
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        
        return nil
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        
        guard let image = image else { return removeImage(for: url) }
        
        let decompressedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decompressedImage.diskSize)
    }
    
    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        decodedImageCache.removeAllObjects()
    }
    
}
