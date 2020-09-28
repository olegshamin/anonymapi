//
//  RegularLabel.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

class RegularLabel: BaseLabel {

    override func commonInit() {
        super.commonInit()

        font = UIFont.systemFont(ofSize: fontSize)
    }
}

final class RegularLabel12: RegularLabel {

    override var fontSize: CGFloat { 12 }
}
