//
//  NetworkManager.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation

class NetworkManager {
    
    func getData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
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
