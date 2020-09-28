//
//  UIImageView+Extension.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

extension UIImageView {
    
    func loadImage(at url: URL?) {
        UIImageLoader.shared.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
