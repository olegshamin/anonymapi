//
//  Post.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

struct Post: Equatable {
    let id: String
    let thumbnailURL: URL?
    let originalURL: URL?
    let text: String
    let createdAt: Date
    let author: Author
}
