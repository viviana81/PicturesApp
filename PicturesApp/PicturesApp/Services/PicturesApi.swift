//
//  PicturesApi.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit
import Moya

enum PicturesApi {
    case getPhotos(page: Int)
    case getTopics(page: Int)
    case search(query: String)
    case getToken(code: String)
    case getMe
    case likePhoto(id: String)
    case getCollections
}

extension PicturesApi: TargetType {
    var baseURL: URL {
        switch self {
        case .getToken:
            return URL(string: "https://unsplash.com/")!
        default:
            return URL(string: "https://api.unsplash.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "photos"
        case .getTopics:
            return "topics"
        case .search:
            return "search/photos"
        case .getToken:
            return "oauth/token"
        case .getMe:
            return "me"
        case .likePhoto(let id):
            return "photos/\(id)/like"
        case .getCollections:
            return "collections"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotos, .getTopics, .search, .getMe, .getCollections:
            return .get
        case .getToken, .likePhoto:
            return .post
        
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPhotos(let page), .getTopics(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .search(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.default)
        case .getToken(let code):
            return .requestParameters(parameters: ["code": code,
                                                   "client_id": "bXdSj1vu0gOXPwaT7vDBDT1mWZF7CE9CYHHsqfj1O9k",
                                                   "client_secret": "G9nvKoXT14NqIrVdB7bsOtE5Gwd80zWoH-8jvOuR53A",
                                                   "redirect_uri": "picturesapp:",
                                                   "grant_type": "authorization_code"], encoding: URLEncoding.default)
        case .likePhoto(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
        case .getMe, .getCollections:
            return .requestPlain

        }
    }
    
    var headers: [String: String]? {
        
        var code = "Client-ID bXdSj1vu0gOXPwaT7vDBDT1mWZF7CE9CYHHsqfj1O9k"
        
        if let userToken = UserDefaultsConfig.token {
            code = "Bearer \(userToken)"
        }
        
        return ["Authorization": code]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
