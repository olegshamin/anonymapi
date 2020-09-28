//
//  APIToPresentationTests.swift
//  TestShowPostsTests
//
//  Created by Oleg Shamin on 28.09.2020.
//

import XCTest
@testable import TestShowPosts

class APIToPresentationMapperTests: XCTestCase {

    // MARK: - Tests

    func testAPIAuthorToAuthor() {
        
        // Given
        let apiAuthor = APIAuthor(id: "id1", name: "name1", photo: nil)
        let expectedAuthor = Author(id: "id1", name: "name1", thumbnailURL: nil, originalURL: nil)
        
        // When
        let author = APIToPresentationMapper.map(apiAuthor: apiAuthor)
        
        // Then
        XCTAssertEqual(author, expectedAuthor)
    }
    
    func testAPIPostToPostsArray() {
        
        // Given
        let apiAuthor = APIAuthor(id: "id1", name: "name1", photo: nil)
        let author = Author(id: "id1", name: "name1", thumbnailURL: nil, originalURL: nil)
        let apiItems = [
            APIItem(id: "item1", contents: [], createdAt: 0, author: apiAuthor),
            APIItem(id: "item2", contents: [], createdAt: 1, author: apiAuthor),
            APIItem(id: "item3", contents: [], createdAt: 2, author: apiAuthor)
        ]
        let apiPostData = APIPostData(items: apiItems, cursor: "cursor")
        let apiPost = APIPost(data: apiPostData)
        
        let expectedPosts = [
            Post(id: "item1", thumbnailURL: nil, originalURL: nil, text: "", createdAt: Date(timeIntervalSince1970: 0), author: author),
            Post(id: "item2", thumbnailURL: nil, originalURL: nil, text: "", createdAt: Date(timeIntervalSince1970: 1), author: author),
            Post(id: "item3", thumbnailURL: nil, originalURL: nil, text: "", createdAt: Date(timeIntervalSince1970: 2), author: author)
        ]
        
        // When
        let posts = APIToPresentationMapper.map(apiPost: apiPost)
        
        // Then
        XCTAssertEqual(expectedPosts.count, posts.count)
        zip(posts, expectedPosts).forEach { (post, expectedPost) in
            XCTAssertEqual(post, expectedPost)
        }
    }
}
