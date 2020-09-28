//
//  ServiceRegisteringHelper.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

enum ServiceRegisteringHelper {

    private static var serviceLocator: ServiceLocator {
        .shared
    }

    static func registerServices() {
        
        registerImageServices()
        registerPostsServices()
    }
    
    // MARK: - Private helpres
    
    private static func registerPostsServices() {
        serviceLocator.register(PostServiceProtocol.self) {
            PostService(networkRepository: serviceLocator.get())
        }
        serviceLocator.register(PostNetworkRepositoryProtocol.self) {
            PostNetworkRepository(networkLayer: serviceLocator.get())
        }
        serviceLocator.register(NetworkLayerProtocol.self) {
            NetworkLayer()
        }
    }
    
    private static func registerImageServices() {
        serviceLocator.register(UIImageLoaderProtocol.self) {
            UIImageLoader(imageService: serviceLocator.get())
        }
        serviceLocator.register(ImageServiceProtocol.self) {
            ImageService(imageCache: serviceLocator.get())
        }
        serviceLocator.register(ImageCacheProtocol.self) {
            ImageCache()
        }
    }
}
