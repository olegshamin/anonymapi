//
//  ConfigurableView.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

protocol ConfigurableView: UIView {

    associatedtype Config

    func configure(with config: Config)
}
