//
//  Filter.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 23/03/21.
//

import UIKit

struct FilterSearch {
    let key: String
    let value: String
}

enum Filter: CaseIterable {
    case keyword
    case positionTitle
    case locationName
    case remunerationMinimumAmount
    case travelPercentage
    case positionScheduleTypeCode
    
    var title: String {
        switch self {
        case .keyword:
        return "Keywords"
        case .positionTitle:
            return "Position Title"
        case .locationName:
            return "Location"
        case .remunerationMinimumAmount:
            return "Minimum salary"
        case .travelPercentage:
            return "Travelling"
        case .positionScheduleTypeCode:
            return "Schedule"
        }
    }
    
    var key: String {
        switch self {
        case .keyword:
        return "Keyword"
        case .positionTitle:
            return "PositionTitle"
        case .locationName:
            return "LocationName"
        case .remunerationMinimumAmount:
            return "RemunerationMinimumAmount"
        case .travelPercentage:
            return "TravelPercentage"
        case .positionScheduleTypeCode:
            return "PositionScheduleTypeCode"
        }
    }
}

/*Filter(name: "Keyword", color: .systemBlue),
Filter(name: "PositionTitle", color: .systemYellow),
Filter(name: "LocationName", color: .systemGreen),
Filter(name: "RemunerationMinimumAmount", color: .systemIndigo),
Filter(name: "TravelPercentage", color: .systemPink),
Filter(name: "PositionScheduleTypeCode", color: .systemOrange)*/
