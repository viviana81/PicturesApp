//
//  LocationViewModel.swift
//  Septa
//
//  Created by Viviana Capolvenere on 17/02/21.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    
    let location: Location
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(location.lat)!, longitude: Double(location.long)!)
    }
    
    init(withLocation location: Location) {
        self.location = location
    }
    
    var title: String? {
        return location.name
    }
    
    var subtitle: String? {
        return "\(location.distance) meters"
    }
}

class LocationViewModel {

    let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    var name: String {
        return location.name
    }
    
    var type: String {
        return location.type
    }
    
    var distance: String {
        return location.distance
    }
}
