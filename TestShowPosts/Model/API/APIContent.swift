//
//  APIContent.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import Foundation

struct APIContent: Decodable {
    let type: String?
    let id: String?
    let data: APIContentData?
}
