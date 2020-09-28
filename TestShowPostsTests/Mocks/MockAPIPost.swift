//
//  MockAPIPost.swift
//  TestShowPostsTests
//
//  Created by Oleg Shamin on 28.09.2020.
//

import Foundation
@testable import TestShowPosts

extension APIPost {
    static var mockPost: APIPost {
        APIPost(data: APIPostData.mockPostData)
    }
}

extension APIPostData {
    static var mockPostData: APIPostData {
        APIPostData(items: [], cursor: "test")
    }
}
