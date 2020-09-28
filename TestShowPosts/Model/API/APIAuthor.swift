//
//  APIAuthor.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import Foundation

struct APIAuthor: Decodable {
    let id: String?
    let name: String?
    let photo: APIPhoto?
}
