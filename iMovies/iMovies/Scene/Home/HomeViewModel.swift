//
//  HomeViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit
import PromiseKit

class HomeViewModel {
    
    let services: Services
    
    init() {
        self.services = ApiServices()
    }
    var nowPlaying: [Film] = []
    var upcoming: [Film] = []
    var popular: [Film] = []
    var top: [Film] = []
    var genres: [Genre] = []

    var reloadData: (() -> Void)?
    
    var sections: [Section] {
        return [
            .nowPlaying,
            .popular,
            .topRated,
            .upcoming
        ]
    }
 
    func fetchData() {
        
        let pNow = nowPromise()
        let pPopular = popularPromise()
        let pUncoming = upcomingPromise()
        let pTop = topPromise()
        let pGenres = genresPromise()
        
        when(fulfilled: pNow, pPopular, pUncoming, pTop, pGenres)
        .done { now, popular, upcoming, top, genres in
            self.nowPlaying = now
            self.popular = popular
            self.top = top
            self.upcoming = upcoming
            self.genres = genres
            self.reloadData?()
        }.catch { error in
            print(error)
        }
    }

    func nowPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getNowPlaying(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
    func upcomingPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getUpcoming(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
    
    func topPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getTopRated(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
    
    func popularPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getPopular(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
    
    func genresPromise() -> Promise<[Genre]> {
        
        return Promise<[Genre]> { seal in
            
            services.getGenre(completion: { (genreResp, error) in
                if let genres = genreResp?.genres {
                    seal.fulfill(genres)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
}
