//
//  Review.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import Foundation

struct Review: Codable {
    let author: String
    let content: String
}

struct ReviewResponse: Codable {
    let id: Int
    let page: Int
    let results: [Review]
    
}
