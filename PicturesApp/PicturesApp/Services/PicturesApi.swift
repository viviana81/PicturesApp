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
    case getTopics
}

extension PicturesApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "photos"
        case .getTopics:
            return "topics"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotos, .getTopics:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPhotos(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .getTopics:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Authorization": "Client-ID bXdSj1vu0gOXPwaT7vDBDT1mWZF7CE9CYHHsqfj1O9k"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}