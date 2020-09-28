//
//  OrderBy.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 28.09.2020.
//

import Foundation

enum OrderBy: String {
    case createdAt, mostPopular, mostCommented
    
    var title: String {

        switch self {
        case .createdAt:
            return NSLocalizedString("Created At", comment: "")
        case .mostPopular:
            return NSLocalizedString("Most Popular", comment: "")
        case .mostCommented:
            return NSLocalizedString("Most Commented", comment: "")
        }
    }
}
