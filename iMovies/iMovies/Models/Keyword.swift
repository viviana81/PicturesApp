//
//  Keyword.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 26/02/21.
//

import Foundation

struct Keyword: Codable {
    let id: Int
    let name: String
}

struct KewordsResponse: Codable {
    let id: Int
    let keywords: [Keyword]
}

struct KeywordMovieResponse: Codable {
    let id: Int
    let page: Int
    let results: [Film]
   // let total_pages: Int
    //let total_results: Int
}
