//
//  APIToPresentationMapper.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

final class APIToPresentationMapper {
    
    // MARK: - Author
    
    static func map(apiAuthor: APIAuthor?) -> Author {
        
        let thumbnailURL = URL(
            string: apiAuthor?.photo?.data?.extraSmall?.url ?? ""
        )
        let originalURL = URL(
            string: apiAuthor?.photo?.data?.original?.url ?? ""
        )
        
        let author = Author(
            id: apiAuthor?.id ?? "",
            name: apiAuthor?.name ?? "",
            thumbnailURL: thumbnailURL,
            originalURL: originalURL
        )
        
        return author
    }
    
    // MARK: - Post
    
    static func map(item: APIItem) -> Post {
        
        var text = ""
        var thumbnailURL: URL?
        var originalURL: URL?
        
        for content in item.contents {
            switch ContentType(rawValue: content.type ?? "") {
            case .image:
                thumbnailURL = URL(string: content.data?.extraSmall?.url ?? "")
                originalURL = URL(string: content.data?.medium?.url ?? content.data?.small?.url ?? "")
                
            case .text:
                text = content.data?.value ?? ""
                
            default: continue
            }
        }

        let post = Post(
            id: item.id ?? "",
            thumbnailURL: thumbnailURL,
            originalURL: originalURL,
            text: text,
            createdAt: Date(timeIntervalSince1970: item.createdAt ?? 0 / 1000),
            author: APIToPresentationMapper.map(apiAuthor: item.author)
        )
        
        return post
    }
    
    static func map(apiPost: APIPost) -> [Post] {
        let posts = apiPost.data?.items.map(APIToPresentationMapper.map) ?? []
        return posts
    }

}
