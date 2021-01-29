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
    
    func getMe(completion: @escaping (User?, Error?) -> Void) {
        provider.request(.getMe) { result in
            switch result {
            case .success(let response):
                let currentUser = try? decoder.decode(User.self, from: response.data)
                completion(currentUser, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func likePhoto(id: String, completion: @escaping (Bool, Error?) -> Void) {
        provider.request(.likePhoto(id: id)) { result in
            switch result {
            case.success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func getCollections(completion: @escaping ([Collection]?, Error?) -> Void) {
        provider.request(.getCollections) { result in
            switch result {
            case .success(let response):
                let collections = try? decoder.decode([Collection].self, from: response.data)
                completion(collections, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func unlikePhoto(id: String, completion: @escaping (Bool, Error?) -> Void) {
        provider.request(.unlikePhoto(id: id)) { result in
            switch result {
            case.success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func addCollection(title: String, description: String, privacy: Bool, completion: @escaping (Bool, Error?) -> Void) {
        provider.request(.addCollection(title: title, description: description, privacy: privacy)) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func getUserCollections(username: String, completion: @escaping ([Collection]?, Error?) -> Void) {
        provider.request(.getUserCollections(username: username)) { result in
            switch result {
            case .success(let response):
                let collections = try? decoder.decode([Collection].self, from: response.data)
                completion(collections, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func addPhotoToCollection(idPhoto: String, idCollection: String, completion: @escaping (Bool, Error?) -> Void) {
        provider.request(.addPhotoToCollection(idPhoto: idPhoto, idCollection: idCollection)) { result in
            switch result {
            case.success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
