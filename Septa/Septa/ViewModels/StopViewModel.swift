//
//  StopViewModel.swift
//  Septa
//
//  Created by Viviana Capolvenere on 18/02/21.
//

import Foundation
import MapKit

class StopViewModel {
    
    let stop: Stop
    
    init(stop: Stop) {
        self.stop = stop
    }
    
    var name: String {
        return stop.stopname
    }
}

class StopAnnotation: NSObject, MKAnnotation {
    
    let stop: Stop
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(stop.lat)!, longitude: Double(stop.lng)!)
    }
    
    init(withStop stop: Stop) {
        self.stop = stop
    }
    
    var title: String? {
        return stop.stopname
    }
}
