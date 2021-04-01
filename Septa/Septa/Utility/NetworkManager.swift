//
//  NetworkManager.swift
//  Septa
//
//  Created by Viviana Capolvenere on 17/02/21.
//

import Foundation

class NetworkManager {
    
    func getData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
        getData(from: .init(url: url), completion: completion)
    }
    
    func getData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            } else if let error = error {
                
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                
            } else {
                
            }
        }
        dataTask.resume()
    }
}
