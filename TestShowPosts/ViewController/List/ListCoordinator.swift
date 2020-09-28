//
//  ListCoordinator.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 27.09.2020.
//

import UIKit

final class ListCoordinator: BaseCoordinator {

    // MARK: - Private properties

    private let navigationController: BaseNavigationController

    // MARK: - Init

    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    // MARK: - API

    override func start(animated: Bool) {

        showListViewController(animated: animated)
    }

    // MARK: - Helpers

    private func showListViewController(animated: Bool) {
        let controller = ListController(postService: ServiceLocator.shared.get())
        let viewController = ListViewController.create(
            controller: controller,
            delegate: self
        )
        
        navigationController.setViewControllers([viewController], animated: animated)
        setStartViewController(viewController)
    }
}

// MARK: - ListViewControllerProtocol

extension ListCoordinator: ListViewControllerProtocol {
    
    func didSelect(post: Post) {
        let viewController = DetailViewController.create(post: post)
        navigationController.pushViewController(viewController, animated: true)
    }
}
