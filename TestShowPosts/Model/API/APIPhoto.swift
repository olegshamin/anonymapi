//
//  APIPhoto.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import Foundation

struct APIPhoto: Decodable {
    let id: String?
    let data: APIPhotoData?
}

struct APIPhotoData: Decodable {
    let extraSmall, original: APIImage?
}
