//
//  StopsViewModel.swift
//  Septa
//
//  Created by Viviana Capolvenere on 18/02/21.
//

import UIKit

class StopsViewModel {
   
    var stops: [Stop] = []
    var searchText: String?
    let manager = NetworkManager()
    var onReloadMap: (() -> Void)?
    
    func getStop(withquery query: String) {
        guard let urls = URL(string: "https://septa.p.rapidapi.com/hackathon/Stops/\(query)") else { return }
        var request = URLRequest(url: urls)
        request.setValue("7514f84c3cmsh0d2706edb1f4838p1f9d95jsn06d5b5b7f339", forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("septa.p.rapidapi.com", forHTTPHeaderField: "X-Rapidapi-Host")
        manager.getData(from: request) { [weak self] data, error in
            if let data = data {
                let stops = try! JSONDecoder().decode([Stop].self, from: data)
                self?.stops = stops
                self?.onReloadMap?()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
