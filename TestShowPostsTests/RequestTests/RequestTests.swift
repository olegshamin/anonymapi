//
//  RequestTests.swift
//  TestShowPostsTests
//
//  Created by Oleg Shamin on 28.09.2020.
//

import XCTest
@testable import TestShowPosts

class RequestTests: XCTestCase {

    // MARK: - Tests
    
    func testAsURLRequest() {
        // Given
        let request = MockRequest()
        
        // When
        guard let urlRequest = try? request.asURLRequest() else {
            XCTFail("Can not create URL request")
            return
        }
        // url with params
        let expectedURL = "/fs-posts/v1\(request.path)"
        
        // Then
        XCTAssertEqual(urlRequest.url?.path, expectedURL)
        XCTAssertEqual(urlRequest.httpMethod, request.method.rawValue)
        XCTAssertEqual(urlRequest.httpBody, request.body)
        for (key, value) in request.headers {
            XCTAssertEqual(urlRequest.allHTTPHeaderFields?[key], value)
        }
    }

}
