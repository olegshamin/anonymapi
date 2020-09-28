//
//  PostRequestTests.swift
//  TestShowPostsTests
//
//  Created by Oleg Shamin on 28.09.2020.
//

import XCTest
@testable import TestShowPosts

class CatImageRequestTests: XCTestCase {

    // MARK: - Tests
    
    func testPostsRequest() {
        
        // Given
        let request = PostsRequest(cursor: "cursor")
        let expectedParams: [String: Any]? = [ServerField.after: "cursor"]
        
        // When
        // Then
        XCTAssertEqual(request.path, "/posts")
        XCTAssertEqual(request.parameters?.count, 1)
        for key in (expectedParams?.keys)! {
            XCTAssertEqual("\(request.parameters?[key] ?? "")", "\(expectedParams?[key] ?? "")")
        }
    }

}
