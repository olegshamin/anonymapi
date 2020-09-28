//
//  ResponseError.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

struct ResponseError: Error, LocalizedError, Codable {
    
    // MARK: - Internal properties
    
    let message: String
    
    // MARK: - Private properties
    
    private let errors: [[String: String]]
    
    // MARK: - Initialization
    
    init(errors: [[String: String]]) {
        self.errors = errors
        
        // I think this is the easiest way to convert errors to string,
        // since I don't have documentation for the backend and don't know which errors are available
        message = errors.map({ $0.first?.value ?? "" }).joined(separator: ", ")
    }
    
    enum Keys: String, CodingKey {
        case errors
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let errors = try container.decode([[String: String]].self, forKey: .errors)

        self.init(errors: errors)
    }
    
    // MARK: - LocalizedError
    
    var errorDescription: String? {
        return message
    }
}
