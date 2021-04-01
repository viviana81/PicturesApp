//
//  DetailViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import Foundation
import PromiseKit
import UIKit

class DetailViewModel {
    
    let services: Services
    let filmId: Int
    var filmVM: FilmViewModel?
    var reloadData: (() -> Void)?
    var reviews: [Review] = []
    var keywords: [Keyword] = []
    var cast: [PeopleCast] = []
    var crew: [PeopleCrew] = []
    var similar: [Film] = []
    var recomended: [Film] = []
    var images: [Image] = []
    var movies: [Film] = []

    init(filmId: Int) {
        self.filmId = filmId
        self.services = ApiServices()
    }
    
    func getFilmDetail() {
        
       // let filmPromise = detailPromise()
        
        when(fulfilled: [detailPromise(), reviewsPromise(), keywordsPromise(), castPromise(), crewPromise(), similarPromise(), recomendedPromise(), imagesPromise()])
        .done { promises in
            
            let film = promises[0] as? Film
            let reviews = promises[1] as? [Review] ?? []
            let keywords = promises[2] as? [Keyword] ?? []
            let cast = promises[3] as? [PeopleCast] ?? []
            let crew = promises[4] as? [PeopleCrew] ?? []
            let similar = promises[5] as? [Film] ?? []
            let recomended = promises[6] as? [Film] ?? []
            let images = promises[7] as? [Image] ?? []
            
            self.filmVM = FilmViewModel(film: film)
            self.reviews = reviews
            self.keywords = keywords
            self.cast = cast
            self.crew = crew
            self.similar = similar
            self.recomended = recomended
            self.images = images
            self.reloadData?()
        }.catch { err in
            print(err)
        }
        
    }
    
    func detailPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getFilm(id: filmId) { (film, error) in
                if let film = film {
                    seal.fulfill(film)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func reviewsPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getReviews(id: filmId) { (reviewResp, error) in
                if let reviews = reviewResp?.results {
                    seal.fulfill(reviews)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func keywordsPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getKeywords(id: filmId) { (keyResp, error) in
                if let keywords = keyResp?.keywords {
                    seal.fulfill(keywords)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func castPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getCredits(id: filmId) { (creditsResp, error) in
                if let cast = creditsResp?.cast {
                    seal.fulfill(cast)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func crewPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getCredits(id: filmId) { (creditsResp, error) in
                if let crew = creditsResp?.crew {
                    seal.fulfill(crew)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func similarPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getSimilar(id: filmId) { (filmResp, error) in
                if let similar = filmResp?.results {
                    seal.fulfill(similar)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func recomendedPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getRecomended(id: filmId) { (filmResp, error) in
                if let similar = filmResp?.results {
                    seal.fulfill(similar)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func imagesPromise() -> Promise<Any> {
        
        return Promise { seal in
            
            services.getImages(id: filmId) { (imagesResp, error) in
                if let images = imagesResp?.posters {
                    seal.fulfill(images)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
}
