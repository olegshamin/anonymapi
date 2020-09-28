//
//  APIPost.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import Foundation

// MARK: - APIPost

// Since I didn't see documentation I assume that everything is Optional or empty array

struct APIPost: Decodable {
    let data: APIPostData?
}

// MARK: - APIPostData

struct APIPostData: Decodable {
    let items: [APIItem]
    let cursor: String?
}
