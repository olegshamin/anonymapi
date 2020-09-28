//
//  NetworkLayer.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

protocol NetworkLayerProtocol {
    func perform(request: Request, completion: @escaping NetworkResultHandler)
}

class NetworkLayer: NetworkLayerProtocol {
    
    // MARK: - Private properties
    
    private let decoder = JSONDecoder()
    
    // MARK: - NetworkLayerProtocol
    
    func perform(request: Request, completion: @escaping NetworkResultHandler) {
        
        do {
            let urlRequest = try request.asURLRequest()
            URLSession.shared.dataTask(with: urlRequest) {
                [weak self] data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                let networkResponse = NetworkResponse(data: data, response: response)
                self?.handle(networkResponse: networkResponse, completion: completion)
                
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Private helpers
    
    private func handle(
        networkResponse: NetworkResponse,
        completion: @escaping NetworkResultHandler
    ) {
        
        let statusCode = networkResponse.response.statusCode
        
        // Because I don't have documentation for server but at least 400 error is 100% exist
        // I'll parse only error 400, for all other errors will show hardcoded "Internal server error"
        
        switch statusCode {
        case 200..<300:
            completion(.success(networkResponse.data))
        case 400:
            handleResponseError(data: networkResponse.data, completion: completion)
        case 401..<600:
            completion(.failure(NetworkError.internalServerError))
        default:
            break
        }
    }

    // MARK: - Error Handlers

    private func handleResponseError(data: Data, completion: @escaping NetworkResultHandler) {
        do {
            let responseError = try decoder.decode(ResponseError.self, from: data)
            completion(.failure(responseError))
        } catch {
            completion(.failure(error))
        }
    }
}
