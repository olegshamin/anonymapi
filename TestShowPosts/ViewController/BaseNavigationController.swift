//
//  BaseNavigationController.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 27.09.2020.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    var didPopViewControllerHandler: ((UIViewController) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationController: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {

        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        didPopViewControllerHandler?(fromViewController)
    }
}
