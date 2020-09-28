//
//  ListController.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

final class ListController: ListControllerProtocol {
    
    // MARK: - Internal properties
    
    weak var view: ListViewProtocol?
    
    // MARK: - Private properties
    
    private let postService: PostServiceProtocol
    
    // MARK: - Initialization
    
    init(postService: PostServiceProtocol) {
        self.postService = postService
    }

    // MARK: - ListControllerProtocol
    
    func reloadData(orderBy: OrderBy) {
        postService.getPosts(orderBy: orderBy) { [weak self] result in
            switch result {
            case .success(let models):
                self?.view?.handleDataReloadSuccess(models: models)
                
            case .failure(let error):
                self?.view?.handle(error: error)
            }
        }
    }
}
