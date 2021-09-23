//
//  VenueCategory.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import Foundation

struct VenueCategory: Codable {
    let categoryId: String
    let name: String
    let icon: VenueCategoryIcon
    
    private enum CodingKeys: String, CodingKey {
        case categoryId = "id"
        case name
        case icon
    }
}
