//
//  Genre.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct MovieGenreResponse: Codable {
    let id: Int
    let page: Int
    let results: [Film]
}
