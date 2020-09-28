//
//  APIContentData.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import Foundation

struct APIContentData: Decodable {
    let extraSmall, small, medium: APIImage?
    let value: String?
}
