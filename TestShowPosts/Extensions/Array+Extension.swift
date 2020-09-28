//
//  Array+Extension.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 28.09.2020.
//

import UIKit

extension Array where Element == NSLayoutConstraint {

    func activate() {
        NSLayoutConstraint.activate(self)
    }
}
