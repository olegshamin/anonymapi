//
//  MockPostServiceRepository.swift
//  TestShowPostsTests
//
//  Created by Oleg Shamin on 28.09.2020.
//

import Foundation
@testable import TestShowPosts

class MockPostNetworkRepository: PostNetworkRepositoryProtocol {
    
    // MARK: - Public properties
    
    var isSuccess = true
    var cursor: String?
    
    // MARK: - PostNetworkRepositoryProtocol
    
    func getPosts(request: PostsRequest, completion: @escaping ResultHandler<APIPost>) {
        
        cursor = request.cursor
        
        if isSuccess {
            completion(.success(APIPost.mockPost))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}
