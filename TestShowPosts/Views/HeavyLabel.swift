//
//  HeavyLabel.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

class HeavyLabel: BaseLabel {

    override func commonInit() {
        super.commonInit()

        font = UIFont.boldSystemFont(ofSize: fontSize)
    }
}

final class HeavyLabel17: HeavyLabel {

    override var fontSize: CGFloat { 17 }
}
