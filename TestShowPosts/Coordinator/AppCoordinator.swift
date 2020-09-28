//
//  AppCoordinator.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

    // MARK: - Private Properties

    private let window: UIWindow
    private let navigationController = BaseNavigationController()

    // MARK: - Init

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    // MARK: - API

    override func start(animated: Bool) {

        let coordinator = ListCoordinator(navigationController: navigationController)
        startCoordinator(coordinator, animated: animated)
        
        window.rootViewController = navigationController
        setStartViewController(navigationController)
        window.makeKeyAndVisible()
    }
}
