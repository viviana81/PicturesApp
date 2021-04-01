//
//  Services.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

protocol Services {
    
    func getNowPlaying(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getPopular(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getTopRated(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getUpcoming(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getGenre(completion: @escaping(GenreResponse?, Error?) -> Void)
    func getFilm(id: Int, completion: @escaping(Film?, Error?) -> Void)
    func getReviews(id: Int, completion: @escaping(ReviewResponse?, Error?) -> Void)
    func getKeywords(id: Int, completion: @escaping(KewordsResponse?, Error?) -> Void)
    func getCredits(id: Int, completion: @escaping(CreditsResponse?, Error?) -> Void)
    func getSimilar(id: Int, completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getRecomended(id: Int, completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getImages(id: Int, completion: @escaping(ImageResponse?, Error?) -> Void)
    func getGenreMovies(id: Int, completion: @escaping(MovieGenreResponse?, Error?) -> Void)
    func getKeywordMovies(id: Int, completion: @escaping(KeywordMovieResponse?, Error?) -> Void)
}
