//
//  PostServiceTests.swift
//  TestShowPostsTests
//
//  Created by Oleg Shamin on 28.09.2020.
//

import XCTest
@testable import TestShowPosts

class PostServiceTests: XCTestCase {
    
    // MARK: - Private properties
    
    private var sut: PostServiceProtocol!
    private var networkRepository: MockPostNetworkRepository!
    
    // MARK: - Life cycle

    override func setUpWithError() throws {
        networkRepository = MockPostNetworkRepository()
        sut = PostService(networkRepository: networkRepository)
    }

    // MARK: - Tests
    
    func testGetPostsSuccessCompletionCalled() {
        
        // Given
        networkRepository.isSuccess = true
        
        // When
        sut.getPosts(orderBy: .createdAt) { result in
            
            if case .failure = result {
                // Then
                XCTFail("Wrong result case: \(result)")
            }
        }
    }
    
    func testGetPostsFailedCompletionCalled() {
        
        // Given
        networkRepository.isSuccess = false
        
        // When
        sut.getPosts(orderBy: .createdAt) { result in
            
            if case .success = result {
                // Then
                XCTFail("Wrong result case: \(result)")
            }
        }
    }
    
    func testCursorNotNilIfReceivedFromServer() {
        
        // Given
        networkRepository.isSuccess = true
               
        XCTAssertNil(networkRepository.cursor)

        // When
        sut.getPosts(orderBy: .createdAt) { _ in
            
            // Then
            XCTAssertNotNil(self.networkRepository.cursor)
        }
    }
}
