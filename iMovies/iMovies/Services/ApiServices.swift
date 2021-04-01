//
//  MovieApi.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Moya

struct ApiServices: Services {
   
    let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: false, cURL: true)])
    
    let decoder: JSONDecoder
    
    init() {
        
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getNowPlaying(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getNowPlaying) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getPopular(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getPopular) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
        
    func getTopRated(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getTopRated) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getUpcoming(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getUpcoming) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func getGenre(completion: @escaping (GenreResponse?, Error?) -> Void) {
        provider.request(.getGenre) { result in
            switch result {
            case .success(let response):
                let genreResp = try? decoder.decode(GenreResponse.self, from: response.data)
                completion(genreResp, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getFilm(id: Int, completion: @escaping (Film?, Error?) -> Void) {
        provider.request(.getFilm(id: id)) { result  in
            switch result {
            case .success(let response):
                let film = try? decoder.decode(Film.self, from: response.data)
                completion(film, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getReviews(id: Int, completion: @escaping (ReviewResponse?, Error?) -> Void) {
        provider.request(.getReviews(id: id)) { result in
            switch result {
            case .success(let response):
                let reviewResp = try? decoder.decode(ReviewResponse.self, from: response.data)
                completion(reviewResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getKeywords(id: Int, completion: @escaping (KewordsResponse?, Error?) -> Void) {
        provider.request(.getKeywords(id: id)) { result in
            switch result {
            case .success(let response):
                let keyResp = try? decoder.decode(KewordsResponse.self, from: response.data)
                completion(keyResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getCredits(id: Int, completion: @escaping (CreditsResponse?, Error?) -> Void) {
        provider.request(.getCredits(id: id)) { result in
            switch result {
            case .success(let response):
                let creditsResp = try? decoder.decode(CreditsResponse.self, from: response.data)
                completion(creditsResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getSimilar(id: Int, completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getSimilar(id: id)) { result  in
            switch result {
            case .success(let response):
                let similar = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(similar, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getRecomended(id: Int, completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getRecomended(id: id)) { result  in
            switch result {
            case .success(let response):
                let recomended = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(recomended, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getImages(id: Int, completion: @escaping (ImageResponse?, Error?) -> Void) {
        provider.request(.getImages(id: id)) { result  in
            switch result {
            case .success(let response):
                let images = try? decoder.decode(ImageResponse.self, from: response.data)
                completion(images, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getGenreMovies(id: Int, completion: @escaping (MovieGenreResponse?, Error?) -> Void) {
        provider.request(.getGenreMovies(id: id)) { result in
            switch result {
            case .success(let response):
                let moviesResp = try? decoder.decode(MovieGenreResponse.self, from: response.data)
                completion(moviesResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func getKeywordMovies(id: Int, completion: @escaping (KeywordMovieResponse?, Error?) -> Void) {
        provider.request(.getKeywordMovies(id: id)) { result in
            switch result {
            case .success(let response):
                let moviesResp = try? decoder.decode(KeywordMovieResponse.self, from: response.data)
                completion(moviesResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
