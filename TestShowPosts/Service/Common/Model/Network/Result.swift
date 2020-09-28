//
//  Result.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

typealias ResultHandler<T> = (Result<T, Error>) -> Void
typealias NetworkResultHandler = (Result<Data, Error>) -> Void
typealias VoidResult = Result<Void, Error>
typealias VoidResultHandler = (VoidResult) -> Void

extension Result where Success == Data {

    func decoded<T: Decodable>(
        using decoder: JSONDecoder = .init()
    ) throws -> T {
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
}
