//
//  UIImageView+Extension.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

extension UIImageView {
    
    func loadImage(at url: URL?) {
        let loader: UIImageLoaderProtocol = ServiceLocator.shared.get()
        loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        let loader: UIImageLoaderProtocol = ServiceLocator.shared.get()
        loader.cancel(for: self)
    }
}
