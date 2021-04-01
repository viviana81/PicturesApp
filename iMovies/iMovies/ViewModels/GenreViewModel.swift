//
//  GenreViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 05/03/21.
//

import Foundation

class GenreViewModel {
    var genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    var name: String {
        return genre.name
    }
}
