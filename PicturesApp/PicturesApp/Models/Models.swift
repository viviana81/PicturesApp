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
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case created = "created_at"
        case id, description, urls, color, user
    }
}

struct User: Codable {
    let id: String
    let name: String
    let instagram: String?
    
    enum CodingKeys: String, CodingKey {
        case instagram = "instagram_username"
        case id, name
    }
}

struct Url: Codable {
    let full: String
    let thumb: String
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
