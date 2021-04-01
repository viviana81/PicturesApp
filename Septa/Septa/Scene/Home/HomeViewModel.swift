//
//  HomeViewModel.swift
//  Septa
//
//  Created by Viviana Capolvenere on 17/02/21.
//

import Foundation
import MapKit
import PromiseKit

class HomeViewModel {
    
    var locationsVM: [LocationViewModel] = []
    var onReloadMap: (() -> Void)?
    
    let manager: NetworkManager
    
    init() {
        self.manager = NetworkManager()
    }
    
    func getLocations() {
        // recupero la posizione utente tramite promisekit/corelocation
        CLLocationManager.requestLocation()
            // ottengo le coordinate da passare a locationPromise
            .then { location in
                self.locationPromise(withCoordinates: location.first!.coordinate)
                // ottengo locations che posso quindi catturare
            }.done { locations in
                self.locationsVM = locations.map { LocationViewModel(location: $0) }
                self.onReloadMap?()
                // qui richiamo una closure che aggiorna l'interfaccia utente
            }.catch { error in
                print(error)
            }
    }
    
    func locationPromise(withCoordinates coordinates: CLLocationCoordinate2D) -> Promise<[Location]> {
        
        return Promise { seal in
            // costruire url
            guard let urls = URL(string: "https://septa.p.rapidapi.com/hackathon/locations/get_locations.php") else { return }
            // compongo l'url perchè ho la query da aggiungere
            var urlcomponent = URLComponents(string: "\(urls)")
            let queryLat = URLQueryItem(name: "lat", value: "\(coordinates.latitude)")
            let queryLong = URLQueryItem(name: "lon", value: "\(coordinates.longitude)")
            urlcomponent?.queryItems = [queryLat, queryLong]
            let url = urlcomponent!.url!
            // aggiungo gli headers
            var request = URLRequest(url: url)
            request.setValue("7514f84c3cmsh0d2706edb1f4838p1f9d95jsn06d5b5b7f339", forHTTPHeaderField: "X-RapidAPI-Key")
            request.setValue("septa.p.rapidapi.com", forHTTPHeaderField: "X-Rapidapi-Host")
            
            manager.getData(from: request) { data, error in
                if let data = data {
                    let locations = try! JSONDecoder().decode([Location].self, from: data)
                    seal.fulfill(locations)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
}
