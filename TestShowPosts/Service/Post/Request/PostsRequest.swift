//
//  PostsRequest.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

struct PostsRequest: Request {
    
    // MARK: - Properties
    
    let orderBy: OrderBy
    let cursor: String?
    
    // MARK: - Request
    
    var path: String {
        "/posts"
    }
    
    var parameters: [String: Any]? {
        
        var result = [ServerField.orderBy: orderBy.rawValue]

        if let cursor = cursor {
            result[ServerField.after] = cursor
        }
        return result
    }
}
