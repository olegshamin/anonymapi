//
//  BaseCoordinator.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

class BaseCoordinator: NavigatableCoordinatorProtocol {

    // MARK: - Public properties

    var childCoordinators: [CoordinatorProtocol] = []

    /// Use it as a `rootViewController`. Basically the first view controller, that is used by the coordinator.
    /// Set it e.g. in `start(animated:)` method
    private(set) weak var startViewController: UIViewController?

    // MARK: - Life cycle

    init() {
        print("\(type(of: self)) is created.")
    }

    deinit {
        print("\(type(of: self)) is destroyed.")
    }

    // MARK: - API

    /// Entry point for the coordinator.
    /// Default implementation does nothing. Override in your subclass.
    /// - Parameter animated: if `true` then animation should be used for the start.
    func start(animated: Bool) {
        // override in a subclass
    }

    /// Sets the given view controller to `startViewControler`.
    /// - Parameter viewController: viewController to be set as a start view controller
    final func setStartViewController(_ viewController: UIViewController) {
        startViewController = viewController
    }

    /// Removes all items from `childCoordinators`.
    func finish() {
        childCoordinators.removeAll()
    }

    /// Appends the given coordinator to `childCoordinators` array and starts it.
    /// - Parameters:
    ///   - coordinator: coordinator to be started.
    ///   - animated: if `true` then animation will be used for the start.
    func startCoordinator(_ coordinator: CoordinatorProtocol, animated: Bool) {

        childCoordinators.append(coordinator)
        coordinator.start(animated: animated)
    }

    /// Removes the given coordinator from `childCoordinators` array.
    /// - Parameter coordinator: coordinator to be removed.
    func removeCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll { $0 === coordinator }
    }

    /// Override in case you need some custom behavior here.
    /// Method is called in `navigationController(_:didPop:)` to check if the coordinator has to be removed.
    /// - Parameter viewController: view controller that was dismissed/popped.
    /// - Returns: Default implementation returns `true` if the given `viewController` and `startViewController` share the same reference.
    func shouldFinishAfterClosing(_ viewController: UIViewController) -> Bool {
        viewController === startViewController
    }

    /// Notifies that the `viewController` has been popped off the navigation stack.
    ///
    /// The coordinator recursively passes this message down the coordinator chain and asks its children
    /// whether they should be finished as a result of the view controller transition. Then, the
    /// children that should be finished are released from memory.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller that performed the transition.
    ///   - viewController: The view controller that was removed from the navigation stack.
    final func navigationController(_ navigationController: UINavigationController, didPop viewController: UIViewController) {

        childCoordinators.forEach { coordinator in

            if let coordinator = coordinator as? NavigatableCoordinatorProtocol {
                coordinator.navigationController(navigationController, didPop: viewController)
            }

            if coordinator.shouldFinishAfterClosing(viewController) {
                removeCoordinator(coordinator)
            }
        }
    }

    /// Sets the handling of pop gesture/action to the `didPopViewControllerhandler` closure of the given `navigationController`
    /// - Parameter navigationController: navigationController that will notify the caller when one of its view controllers was removed from the navigation stack
    final func setPopHandler(for navigationController: BaseNavigationController) {

        navigationController.didPopViewControllerHandler = { [weak self, weak navigationController] viewController in

            if let navigationController = navigationController {
                self?.navigationController(navigationController, didPop: viewController)
            }
        }
    }
}
