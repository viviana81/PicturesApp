//
//  FilmViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

class FilmViewModel {
    var film: Film
    // TODO: failable init (cercare)
    init?(film: Film?) {
        guard let film = film else { return nil }
        self.film = film
    }
    
    var poster: String {
        return film.poster
    }
    
    var title: String {
        return film.title
    }
    
    var date: String {
       
        return film.date
    }
    
    var vote: String {
        return String(film.vote)
    }
    
    var description: String {
        return film.overview
    }
    var detail: String {
        guard let runtime = film.runtime,
              let status = film.status else { return " " }
        
        return "\(film.date) - \(runtime) minutes - \(status)"
    }
    
    var background: String? {
        return film.backdrop
    }
    
    var detailVote: String {
        return "Vote: \(film.vote)"
    }
    
    var genreText: String? {
        guard let genres = film.genres else { return nil }
        let genresString = genres.map { String($0.name)}
        let joined = genresString.joined(separator: " - ")
        return joined
    }
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
    }
    
    var backgroundURL: URL? {
        guard let background = background else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(background)")
    }
}
