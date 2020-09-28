//
//  NetworkError.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case invalidURL(url: String)
    case invalidResponse
    case internalServerError
    
    var errorDescription: String? {
        
        switch self {
        case .invalidURL(let url):
            return .localizedStringWithFormat("Invalid url: '%@'", "\(url)")
            
        case .invalidResponse:
            return NSLocalizedString("Invalid response from server", comment: "")
            
        case .internalServerError:
            return NSLocalizedString("Internal server error", comment: "")
        }
    }
}
