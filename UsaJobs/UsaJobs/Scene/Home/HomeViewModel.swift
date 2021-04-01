//
//  HomeViewModel.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 22/03/21.
//

import Foundation

class HomeViewModel {
    
    var jobs: [Job] = []
    var jobVD: JobViewData?
    let networkManager = NetworkManager()
    var reloadData: (() -> Void)?
    var searchText: String?
    var filter: Filter?
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    func searchJobs(withFilter filter: FilterSearch) {
        // fare struct filter con chiave valore da passare alla query item
        // spostare chiamata di rete nella home
      
        let urlString = "https://data.usajobs.gov/api/search"
        
        guard let urls = URL(string: urlString) else { return }
       
        var urlcomponent = URLComponents(string: "\(urls)")
        
        let queryKeyword = URLQueryItem(name: filter.key, value: filter.value)
        urlcomponent?.queryItems = [queryKeyword]
        
        let url = urlcomponent!.url!
        var request = URLRequest(url: url)
        request.setValue("GToL3oUVvbD9Qnu0ltJy4eCfLI0KU+nKzvXKSD+bqN0=", forHTTPHeaderField: "Authorization-Key")
        request.setValue("vivianacapolvenere@gmail.com", forHTTPHeaderField: "User-Agent")
        request.setValue("data.usajobs.gov", forHTTPHeaderField: "Host")
        
        networkManager.getData(from: request) { [weak self] data, error in
            if let data = data {
                let jobsResp = try? self?.decoder.decode(JobResponse.self, from: data)
                self?.jobs = jobsResp?.searchResult.items ?? []
                self?.reloadData?()
            } else if let error = error {
                print(error)
            }
        }
    }
}
