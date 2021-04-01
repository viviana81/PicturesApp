//
//  StopsViewController.swift
//  Septa
//
//  Created by Viviana Capolvenere on 18/02/21.
//

import UIKit
import MapKit

class StopsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private let stopsVM: StopsViewModel
    var polyline: MKPolyline = MKPolyline()
    
    init(stopsVM: StopsViewModel) {
        self.stopsVM = stopsVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var resultSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        // controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        controller.searchBar.tintColor = .white
        controller.searchBar.placeholder = "Search by route"
        // controller.searchBar.textColor = .white
        controller.searchBar.delegate = self
        return controller
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = resultSearchController.searchBar
        
        stopsVM.onReloadMap = {
            
            let coords = self.stopsVM.stops.map {
                 CLLocationCoordinate2D(latitude: Double($0.lat)!, longitude: Double($0.lng)!)
            }
            let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
                
            self.mapView.addOverlay(myPolyline)
            self.zoomForAllOverlays()
            
        }
    }
    
    func zoomForAllOverlays() {
        guard let initial = mapView.overlays.first?.boundingMapRect else { return }

        let mapRect = mapView.overlays
            .dropFirst()
            .reduce(initial) { $0.union($1.boundingMapRect) }

        mapView.setVisibleMapRect(mapRect, edgePadding: .zero, animated: true)
    }
}

extension StopsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        stopsVM.searchText = searchController.searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        stopsVM.getStop(withquery: text)
        resultSearchController.isActive = false
    }
}
extension StopsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is StopAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            // annotationView!.image = UIImage(systemName: "pin")
        } else {
            annotationView!.annotation = annotation
            
        }
        
        annotationView!.canShowCallout = true
        annotationView!.calloutOffset = CGPoint(x: -5, y: 5)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.red
            polylineRenderer.lineWidth = 1
            return polylineRenderer
        }
        
        fatalError()
    }
}
