//
//  UIImageLoader.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

protocol UIImageLoaderProtocol {
    func load(_ url: URL?, for imageView: UIImageView)
    func cancel(for imageView: UIImageView)
}

final class UIImageLoader: UIImageLoaderProtocol {
    
    // MARK: - Internal properties
    
    static let shared = UIImageLoader()
    
    // MARK: - Private properties
    
    private let imageService: ImageServiceProtocol = ServiceLocator.shared.get()
    private var uuidMap: [UIImageView: UUID] = [:]
    
    // MARK: - UIImageLoaderProtocol
    
    func load(_ url: URL?, for imageView: UIImageView) {
        
        guard let url = url else { return }
        
        let token = imageService.loadImage(from: url) { result in
            
            defer { self.uuidMap.removeValue(forKey: imageView) }
            
            do {
                
                let image = try result.get()
                imageView.image = image
                imageView.setNeedsLayout()
                
            } catch {
                // handle the error
            }
        }
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageService.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
