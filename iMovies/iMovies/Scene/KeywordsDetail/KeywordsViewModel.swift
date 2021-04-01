//
//  KeywordsViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 17/03/21.
//

import Foundation

class KeywordsViewModel {
    
    var movies: [Film] = []
    let keyword: Keyword
    let services: Services
    var reloadData: (() -> Void)?
    
    init(keyword: Keyword) {
        self.keyword = keyword
        self.services = ApiServices()
    }
    
    func getMoviesByKeywords() {
        
        services.getKeywordMovies(id: keyword.id) { moviesResp, error in
            if let moviesResp = moviesResp {
                self.movies = moviesResp.results
                self.reloadData?()
            } else if let error = error {
                print(error)
            }
        }
    }
}
