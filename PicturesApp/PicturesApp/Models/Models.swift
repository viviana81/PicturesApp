//
//  Model.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import Foundation

struct Photo {
    let id: String
    let descritpion: String
    let user: User
}

struct  User {
    let id: String
    let name: String
    let instagram: String
    
    enum CodingKeys: String, CodingKey {
        case instagram = "instagram_username"
        case id, case name
    }
}
