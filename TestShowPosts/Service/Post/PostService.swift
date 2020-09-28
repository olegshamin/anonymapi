//
//  PostService.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

protocol PostServiceProtocol: Service {
    func getPosts(orderBy: OrderBy, completion: @escaping ResultHandler<[Post]>)
}

final class PostService: PostServiceProtocol {
    
    // MARK: - Private properties
    
    private let networkRepository: PostNetworkRepositoryProtocol
    private var previousOrder = OrderBy.createdAt
    private var cursor: String?
    
    // MARK: - Initialization
    
    init(
        networkRepository: PostNetworkRepositoryProtocol
    ) {
        self.networkRepository = networkRepository
    }
    
    // MARK: - PostServiceProtocol
    
    func getPosts(
        orderBy: OrderBy,
        completion: @escaping ResultHandler<[Post]>
    ) {

        if previousOrder != orderBy {
            
            // Clear cursor if user change orderBy
            cursor = nil
        }
        previousOrder = orderBy

        let request = PostsRequest(orderBy: orderBy, cursor: cursor)
        
        DispatchQueue.global(qos: .background).async {
            self.networkRepository.getPosts(request: request) { [weak self] result in
                self?.handle(result: result, completion: completion)
            }
        }
    }
    
    // MARK: - Private helpers
    
    private func handle(
        result: Result<APIPost, Error>,
        completion: @escaping ResultHandler<[Post]>
    ) {
        switch result {
        case .success(let apiPost):
            let posts = APIToPresentationMapper.map(apiPost: apiPost)
            cursor = apiPost.data?.cursor
            handle(success: posts, completion: completion)
            
        case .failure(let error):
            handle(error: error, completion: completion)
        }
    }
}
