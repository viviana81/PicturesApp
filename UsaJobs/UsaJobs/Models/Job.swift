//
//  Job.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 22/03/21.
//

import Foundation

struct Job: Codable {
    let details: MatchedObjectDescriptor
    
    enum CodingKeys: String, CodingKey {
        case details = "MatchedObjectDescriptor"
    }
}

struct MatchedObjectDescriptor: Codable {
    let positionTitle: String
    let positionStartDate: String
    let positionEndDate: String
    let positionLocation: String
    let description: UserArea
    
    enum CodingKeys: String, CodingKey {
        case positionTitle = "PositionTitle"
        case positionStartDate = "PositionStartDate"
        case positionEndDate = "PositionEndDate"
        case positionLocation = "PositionLocationDisplay"
        case description = "UserArea"
    }
    
}

struct UserArea: Codable {
    let details: Details
    
    enum CodingKeys: String, CodingKey {
        case details = "Details"
    }
}

struct Details: Codable {
    let jobDescription: String
    
    enum CodingKeys: String, CodingKey {
        case jobDescription = "JobSummary"
    }
}

struct JobResponse: Codable {
    let searchResult: SearchResult
    
    enum CodingKeys: String, CodingKey {
        case searchResult = "SearchResult"
    }
}

struct SearchResult: Codable {
    let resultCount: Int
    let resultCountAll: Int
    let items: [Job]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "SearchResultCount"
        case resultCountAll = "SearchResultCountAll"
        case items =  "SearchResultItems"
    }
}
