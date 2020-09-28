//
//  PostNetworkRepository.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

protocol PostNetworkRepositoryProtocol {
    func getPosts(request: PostsRequest, completion: @escaping ResultHandler<APIPost>)
}

final class PostNetworkRepository: PostNetworkRepositoryProtocol{
    
    // MARK: - Private properties
    
    private let networkLayer: NetworkLayerProtocol
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization
    
    init(networkLayer: NetworkLayerProtocol = NetworkLayer()) {
        self.networkLayer = networkLayer
    }
    
    // MARK: - PostNetworkRepositoryProtocol
    
    func getPosts(
        request: PostsRequest,
        completion: @escaping ResultHandler<APIPost>
    ) {
        networkLayer.perform(request: request) { [weak self] result in
            self?.handle(postsResult: result, completion: completion)
        }
    }
    
    // MARK: - Private helpers
    
    private func handle(
        postsResult result: Result<Data, Error>,
        completion: @escaping ResultHandler<APIPost>
    ) {
        do {
            let apiPost = try result.decoded() as APIPost
            completion(.success(apiPost))
        } catch {
            completion(.failure(error))
        }
    }
}
