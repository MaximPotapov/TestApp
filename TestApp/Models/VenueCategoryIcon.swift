//
//  VenueCategoryIcon.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import Foundation

struct VenueCategoryIcon: Codable {
    let prefix: String
    let suffix: String

    var categoryIconUrl: String {
        return String(format: "%@%d%@", prefix, 88, suffix)
    }
}
