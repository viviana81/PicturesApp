//
//  Artist.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation

struct Album: Codable {
    let artistName: String
    let trackName: String
    let image: String
    let releaseDate: Date
    let collectionPrice: Double
    let trackPrice: Double
    let biggerImage: String
    let sound: String
    
    enum CodingKeys: String, CodingKey {
        case image = "artworkUrl30"
        case biggerImage = "artworkUrl100"
        case sound = "previewUrl"
        case artistName, trackName, releaseDate, collectionPrice, trackPrice
    }
}

struct SearchedResponse<T: Decodable>: Decodable {
    let resultCount: Int
    let results: [T]
}
