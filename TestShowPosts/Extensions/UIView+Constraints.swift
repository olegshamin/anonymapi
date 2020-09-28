//
//  UIView+Constraints.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

extension UIView.PinEdge {

    static var top: Self {
        .top(0)
    }

    static var leading: Self {
        .leading(0)
    }

    static var trailing: Self {
        .trailing(0)
    }

    static var bottom: Self {
        .bottom(0)
    }

    static var centerX: Self {
        .centerX(0)
    }

    static var centerY: Self {
        .centerY(0)
    }
}

extension UIView {

    enum PinEdge {
        case top(CGFloat), leading(CGFloat), trailing(CGFloat), bottom(CGFloat), centerX(CGFloat), centerY(CGFloat)
    }
}

extension UIView {

    func enableAutoresizingMask() {
        translatesAutoresizingMaskIntoConstraints = true
    }

    func disableAutoresizingMask() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// Creates set of constraints for subviews in relation to its superview
    /// - Warning: You don't have to specify negative values for trailing and bottom constants.
    /// This is done automatically

    /// - parameter insets: Insets that specify top, leading, bottom, trailing constraints for the subview
    /// - returns: Array of created constraints in the same order, as values of UIEdgeInsets (tlbr).
    /// If view doesn't have superview, returns empty array
    func edgeConstraintsToParent(with insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {

        if let parentView = superview {
            return edgeConstraints(to: parentView, with: insets)
        } else {
            return []
        }
    }

    /// Creates set of constraints for subviews in relation to specified view
    /// - Warning: You don't have to specify negative values for trailing and bottom constants.
    /// This is done automatically

    /// - parameter insets: Insets that specify top, leading, bottom, trailing constraints for the subview
    /// - returns: array of created constraints in the same order, as values of UIEdgeInsets (tlbr)
    func edgeConstraints(to parentView: UIView, with insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        edgeConstraints(to: parentView, on: [.top(insets.top), .leading(insets.left), .bottom(insets.bottom), .trailing(insets.right)])
    }

    func edgeConstraints(to view: UIView, on edges: [PinEdge]) -> [NSLayoutConstraint] {

        edges.map { edge in

            switch edge {
            case let .top(offset):
                return topAnchor.constraint(equalTo: view.topAnchor, constant: offset)
            case let .leading(offset):
                return leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset)
            case let .trailing(offset):
                return view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: offset)
            case let .bottom(offset):
                return view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: offset)
            case let .centerX(offset):
                return centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset)
            case let .centerY(offset):
                return centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset)
            }
        }
    }
    
    private var widthConstraint: NSLayoutConstraint? {
        // you should not add more than one required widthConstraint to your view
        return self.constraints.first(where: { $0.firstAttribute == .width && $0.priority == .required })
    }

    private var heightConstraint: NSLayoutConstraint? {
        // you should not add more than one required widthConstraint to your view
        return self.constraints.first(where: { $0.firstAttribute == .height && $0.priority == .required })
    }

    var widthConstraintConstant: CGFloat? {

        get {
            return self.widthConstraint?.constant
        }
        set {
            // setting active to false will delete the constraint immediately
            self.widthConstraint?.isActive = false
            if let width = newValue {
                self.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
    }

    var heightConstraintConstant: CGFloat? {

        get {
            return self.heightConstraint?.constant
        }
        set {
            // setting active to false will delete the constraint immediately
            self.heightConstraint?.isActive = false
            if let height = newValue {
                self.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
}
