//
//  Venue.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import Foundation

struct Venue: Codable {
    var venueId: String?
    var name: String?
    var location: Location?
    var categories: [VenueCategory]?
    
    enum CodingKeys: String, CodingKey {
        case venueId
        case name
        case location
        case categories
    }
    
    init(venueId: String?, name: String?, location: Location?, categories: [VenueCategory]?) {
        self.venueId = venueId
        self.name = name
        self.location = location
        self .categories = categories
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        venueId = (try? values.decodeIfPresent(String.self, forKey: CodingKeys.venueId)) ?? nil
        name = (try? values.decodeIfPresent(String.self, forKey: CodingKeys.name)) ?? nil
        location = (try? values.decodeIfPresent(Location.self, forKey: CodingKeys.location)) ?? nil
        categories = (try? values.decodeIfPresent([VenueCategory].self, forKey: CodingKeys.categories)) ?? nil
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(venueId, forKey: .venueId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(categories, forKey: .categories)
        
    }
}
