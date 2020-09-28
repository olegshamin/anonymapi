//
//  UIViewController+Alert.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 28.09.2020.
//

import UIKit

extension UIViewController {
    
    /// Display UIAlert with OK button
    ///
    /// - Parameter title: Title of UIAlert
    /// - Parameter message: Message of UIAlert
    /// - Parameter okHandler: Handler for the OK button
    func displayOKAlert(withTitle title: String, message: String, okHandler: (() -> Void)? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
            okHandler?()
        }
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    
    /// Display UIAlert with OK button and  title "Error" and localized description from the Error
    ///
    /// - Parameter error: Error where to get the message from
    /// - Parameter okHandler: Handler for the OK button
    func display(error: Error, okHandler: (() -> Void)? = nil) {
        let title = NSLocalizedString("Error", comment: "")
        let message = error.localizedDescription
        displayOKAlert(withTitle: title, message: message, okHandler: okHandler)
    }
    
}
