//
//  Model.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import Foundation

struct Photo: Codable {
    let id: String
    let descritpion: String
    let urls: Url
    let user: User
}

struct User: Codable {
    let id: String
    let name: String
    let instagram: String
    
    enum CodingKeys: String, CodingKey {
        case instagram = "instagram_username"
        case id, name
    }
}

struct Url: Codable {
    let full: String
    let thumb: String
}
