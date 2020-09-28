//
//  APIItem.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import Foundation

struct APIItem: Decodable {
    let id: String?
    let contents: [APIContent]
    let createdAt: Double?
    let author: APIAuthor?
}
