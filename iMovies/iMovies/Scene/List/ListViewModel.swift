//
//  ListViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import Foundation

class ListViewModel {
    
    var filmViewModels: [FilmViewModel]
    
    init(withFilms films: [Film]) {
        filmViewModels = films.compactMap { FilmViewModel(film: $0) }

    }
}
