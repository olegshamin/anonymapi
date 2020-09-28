//
//  String+Extension.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

extension String {
    
    /// Returns a URLComponents if `self` represents a valid URL string that conforms to RFC 2396 or throws an `NetworkError`.
    ///
    /// - throws: `NetworkError.invalidURL` if `self` is not a valid URL string.
    /// - returns: A URLComponents or throws an `NetworkError`.
    func asURL() throws -> URLComponents {
        guard let url = URLComponents(string: self) else {
            throw NetworkError.invalidURL(url: self)
        }
        return url
    }
}
