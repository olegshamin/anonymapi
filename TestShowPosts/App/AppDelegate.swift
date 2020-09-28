//
//  AppDelegate.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    private var coordinator: AppCoordinator!
    
    // MARK: - AppDelegate

    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        ServiceRegisteringHelper.registerServices()
        return true
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        setupMainCoordinator()
        return true
    }

    // MARK: - Private helpers
    
    private func setupMainCoordinator() {

        let mainWindow = UIWindow(frame: UIScreen.main.bounds)

        window = mainWindow

        coordinator = AppCoordinator(
            window: mainWindow
        )

        coordinator.start(animated: false)
    }
}

