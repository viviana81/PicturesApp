//
//  Film.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

struct Film: Codable {
    let adult: Bool
    let backdrop: String?
    let id: Int
    let title: String
    let language: String
    let overview: String
    let poster: String
    let vote: Double
    let date: String
    let runtime: Int?
    let status: String?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case title = "original_title"
        case language = "original_language"
        case poster = "poster_path"
        case vote = "vote_average"
        case date = "release_date"
        case id, overview, adult, runtime, status, genres
    }
}

struct FilmResponse<T: Decodable>: Decodable {
   // let dates:
    let page: Int
    let results: [T]

}
