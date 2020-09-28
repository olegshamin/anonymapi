//
//  ImageService.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

protocol ImageServiceProtocol {
    func loadImage(from url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelLoad(_ uuid: UUID)
}

final class ImageService: ImageServiceProtocol, Service {
    
    // MARK: - Private properties
    
    private let imageCache: ImageCacheProtocol
    private var runningRequests: [UUID: URLSessionDataTask] = [:]
    
    // MARK: - Initialization
    
    init(imageCache: ImageCacheProtocol) {
        self.imageCache = imageCache
    }
    
    // MARK: - ImageServiceProtocol
    
    func loadImage(from url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        guard let url = url else {
            return nil
        }
        
        if let image = imageCache.image(for: url) {
            handle(success: image, completion: completion)
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            defer { self.runningRequests.removeValue(forKey: uuid) }
            
            
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.insertImage(image, for: url)
                self.handle(success: image, completion: completion)
                return
            }
            
            // If error is something except NSURLErrorCancelled - call completion
            guard let error = error else { return }
            guard (error as NSError).code == NSURLErrorCancelled else {
                self.handle(error: error, completion: completion)
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
