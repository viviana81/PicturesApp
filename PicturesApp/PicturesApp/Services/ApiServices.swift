//
//  ApiServices.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import Foundation
import Moya

struct ApiServices: Services {
    
    let provider = MoyaProvider<PicturesApi>(plugins: [NetworkLoggerPlugin(verbose: false, cURL: true)])
    
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
    }
    
    func getPhotos(page: Int, completion: @escaping ([Photo]?, Error?) -> Void) {
        provider.request(.getPhotos(page: page)) { result in
            switch result {
            case .success(let response):
                let photos = try? decoder.decode([Photo].self, from: response.data)
                completion(photos, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getTopics(completion: @escaping ([Topic]?, Error?) -> Void) {
        provider.request(.getTopics) { result in
            switch result {
            case .success(let response):
                let topics = try? decoder.decode([Topic].self, from: response.data)
                completion(topics, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
