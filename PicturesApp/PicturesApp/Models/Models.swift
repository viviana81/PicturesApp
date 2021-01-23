//
//  Model.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import Foundation

struct Photo: Codable {
    let id: String
    let description: String?
    let urls: Url
    let user: User?
    let color: String?
    let created: Date?
    let likes: Int?
    let width: Int?
    let height: Int?
    
    enum CodingKeys: String, CodingKey {
        case created = "created_at"
        case id, description, urls, color, user, likes, width, height
    }
}

struct User: Codable {
    let id: String
    let name: String
    let instagram: String?
    let imageProfile: ImageProfile
    let location: String?
    
    enum CodingKeys: String, CodingKey {
        case instagram = "instagram_username"
        case imageProfile = "profile_image"
        case id, name, location
    }
}

struct ImageProfile: Codable {
    let small: String
    let medium: String
    let large: String
}

struct Url: Codable {
    let full: String
    let thumb: String
    let regular: String
}

struct Topic: Codable {
    let id: String
    let title: String
    let previewPhotos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case previewPhotos = "preview_photos"
        case id, title
    }
}

struct SearchedResponse<T: Decodable>: Decodable {
    let total: Int
    let pages: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case pages = "total_pages"
        case total, results
    }
}

struct Token: Codable {
    let access: String
    let type: String
    let scope: String
    let created: Int

    enum CodingKeys: String, CodingKey {
        case access = "access_token"
        case type =  "token_type"
        case created = "created_at"
        case scope
    }
}
