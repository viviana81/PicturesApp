//
//  ApiServices.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Moya

enum MovieApi {
    case getNowPlaying
    case getPopular
    case getTopRated
    case getUpcoming
    case getGenre
    case getFilm(id: Int)
    case getReviews(id: Int)
    case getKeywords(id: Int)
    case getCredits(id: Int)
    case getSimilar(id: Int)
    case getRecomended(id: Int)
    case getImages(id: Int)
    case getGenreMovies(id: Int)
    case getKeywordMovies(id: Int)
}

extension MovieApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .getNowPlaying:
            return "movie/now_playing"
        case .getPopular:
            return "movie/popular"
        case .getTopRated:
            return "movie/top_rated"
        case .getUpcoming:
            return "movie/upcoming"
        case .getGenre:
            return "genre/movie/list"
        case .getFilm(let id):
            return "movie/\(id)"
        case .getReviews(let id):
            return "movie/\(id)/reviews"
        case .getKeywords(let id):
            return "movie/\(id)/keywords"
        case .getCredits(let id):
            return "movie/\(id)/credits"
        case .getSimilar(let id):
            return "movie/\(id)/similar"
        case .getRecomended(let id):
            return "movie/\(id)/recommendations"
        case .getImages(let id):
            return "movie/\(id)/images"
        case .getGenreMovies(let id):
            return "genre/\(id)/movies"
        case .getKeywordMovies(let id):
            return "keyword/\(id)/movies"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopular, .getNowPlaying, .getTopRated, .getUpcoming, .getGenre, .getFilm, .getReviews, .getKeywords, .getCredits, .getSimilar, .getRecomended, .getImages, .getGenreMovies, .getKeywordMovies:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getNowPlaying, .getPopular, .getTopRated, .getUpcoming, .getGenre, .getFilm, .getReviews, .getKeywords, .getCredits, .getSimilar, .getRecomended, .getImages, .getGenreMovies, .getKeywordMovies:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        
        let code = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZjAzZWNhYzgwMDhhODhkZTkyZDI3OTU1NGVhMjJjMCIsInN1YiI6IjYwMzM1NDhmZmFiM2ZhMDAzYzAxMTI3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EyqTwH6EAjUc9Yi9AnXtDtAGbqJRHfDok02lrvCRUG0"
        
        return ["Authorization": code]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
