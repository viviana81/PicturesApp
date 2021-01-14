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
    
    func getPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
        provider.request(.getPhotos) { result in
            switch result {
            case .success(let response):
                let photos = try? decoder.decode([Photo].self, from: response.data)
                completion(photos, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
