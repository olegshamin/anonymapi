//
//  BaseLabel.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

class BaseLabel: UILabel {
    
    // MARK: - Properties
    
    var fontSize: CGFloat { return 0 }

    // MARK: - Initialization
    
    convenience init(text: String) {
        self.init(frame: .zero)

        self.text = text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    func commonInit() {
        numberOfLines = 0
    }

    func setupUI() {
        disableAutoresizingMask()
    }
}
