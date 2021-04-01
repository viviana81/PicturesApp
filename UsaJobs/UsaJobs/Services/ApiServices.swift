//
//  ApiServices.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 23/03/21.
//

import Foundation
/*
class ApiServices: Services {
    
    let networkManager = NetworkManager()
    let decoder = JSONDecoder()

    func getJobs(query: String, completion: @escaping (JobResponse?, Error?) -> Void) {
        guard let url = URL(string: "https://data.usajobs.gov/api/search") else { return }
        networkManager.getData(from: url) { data, error  in
            if let data = data {
                let jobResp = try? self.decoder.decode(JobResponse.self, from: data)
                completion(jobResp, nil)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
}*/
