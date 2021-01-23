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
        decoder.dateDecodingStrategy = .iso8601
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
    
    func getTopics(page: Int, completion: @escaping ([Topic]?, Error?) -> Void) {
        provider.request(.getTopics(page: page)) { result in
            switch result {
            case .success(let response):
                let topics = try? decoder.decode([Topic].self, from: response.data)
                completion(topics, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func search(query: String, completion: @escaping (SearchedResponse<Photo>?, Error?) -> Void) {
        provider.request(.search(query: query)) { result in
            switch result {
            case .success(let response):
                let searchedResp = try? decoder.decode(SearchedResponse<Photo>.self, from: response.data)
                completion(searchedResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getToken(code: String, completion: @escaping (Token?, Error?) -> Void) {
        provider.request(.getToken(code: code)) { result in
            switch result {
            case .success(let response):
                let token = try? decoder.decode(Token.self, from: response.data)
                completion(token, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
