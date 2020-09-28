//
//  UIView+Subviews.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

extension UIView {

    typealias ViewContraintsBlock<T: UIView> = (_ childView: T, _ parentView: UIView) -> [NSLayoutConstraint]
}

extension UIView {

    /// Adds subview to the view and applies edge constraints with provided insets
    ///
    /// - parameter subview: The view to be added
    /// - parameter insets: Insets that specify top, leading, bottom, trailing constraints for the subview
    func add(subview: UIView, withInsets insets: UIEdgeInsets = .zero) {
        add(subview: subview) { childView, _ in childView.edgeConstraintsToParent(with: insets) }
    }

    ///  Adds subview to the view and applies constraints specified in closure
    ///
    /// - Parameters:
    ///   - subview: Subview to be added
    ///   - constraints: Closure in which you have to return constraints that will be applied to childView and parentView
    func add<T: UIView>(subview: T, constraints: ViewContraintsBlock<T>) {
        insert(subview: subview, at: subviews.count, constraints: constraints)
    }

    func add<T: UIView>(subview: T, withPinEdges pinEdges: [PinEdge], constraints: ViewContraintsBlock<T>? = nil) {

        add(subview: subview) { childView, parentView in

            let innerConstraints = childView.edgeConstraints(to: parentView, on: pinEdges)
            let outerConstraints = constraints?(childView, parentView)
            return (outerConstraints ?? []) + innerConstraints
        }
    }

    /// Inserts a subview at the specified index and applies constraints specified in closure
    ///
    /// - Parameters:
    ///   - subview: Subview to insert
    ///   - index: Index of `subviews` at which to insert subview
    ///   - constraints: Closure in which you have to return constraints that will be applied to childView and parentView
    func insert<T: UIView>(subview: T, at index: Int, constraints: ((_ childView: T, _ parentView: UIView) -> [NSLayoutConstraint])) {
        subview.disableAutoresizingMask()

        insertSubview(subview, at: index)
        NSLayoutConstraint.activate(constraints(subview, self))
    }
}
