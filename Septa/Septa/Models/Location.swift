//
//  Location.swift
//  Septa
//
//  Created by Viviana Capolvenere on 17/02/21.
//

import Foundation

struct Location: Codable {
    let id: String
    let name: String
    let lat: String
    let long: String
    let type: String
    let distance: String
    
    enum CodingKeys: String, CodingKey {
        case id = "location_id"
        case name = "location_name"
        case lat = "location_lat"
        case long = "location_lon"
        case type = "location_type"
        
        case distance
    }
}
