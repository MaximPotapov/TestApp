//
//  VenueLocation.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import Foundation

struct Location: Codable {
    let address: String?
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case address
        case latitude = "lat"
        case longitude = "lng"
    }
}
