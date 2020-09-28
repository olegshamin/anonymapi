//
//  CoordinatorProtocol.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

protocol CoordinatorProtocol: class {

    func start(animated: Bool)
    func finish()

    func shouldFinishAfterClosing(_ viewController: UIViewController) -> Bool
}

protocol NavigatableCoordinatorProtocol: CoordinatorProtocol {

    func navigationController(_ navigationController: UINavigationController, didPop viewController: UIViewController)
}
