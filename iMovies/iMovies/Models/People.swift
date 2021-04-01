//
//  People.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 01/03/21.
//

import Foundation

struct PeopleCast: Codable {
    let name: String?
    let character: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case image = "profile_path"
        case character, name
    }
}

struct PeopleCrew: Codable {
    let name: String?
    let department: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case image = "profile_path"
        case department, name
    }
}

struct CreditsResponse: Codable {
    let id: Int?
    let cast: [PeopleCast]?
    let crew: [PeopleCrew]?
}
