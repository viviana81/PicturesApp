//
//  Images.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 25/02/21.
//

import Foundation

struct Image: Codable {
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case path = "file_path"
    }
}

struct ImageResponse: Codable {
    let id: Int
    let backdrops: [Image]
    let posters: [Image]
}
