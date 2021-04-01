//
//  ViewController.swift
//  Septa
//
//  Created by Viviana Capolvenere on 15/02/21.
//

import UIKit
import MapKit

protocol HomeViewControllerDelegate: class {
    func goToSearch()
}

class HomeViewController: UIViewController {
    
    @IBOutlet private var mapView: MKMapView!
    private let homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    weak var delegate: HomeViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nearest bus stop"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchStops))
        
        homeVM.getLocations()
        mapView.delegate = self
        
        homeVM.onReloadMap = {
            // assegno il mio array di location view model ad annots
            let annots = self.homeVM.locationsVM.map { LocationAnnotation(withLocation: $0.location) }
            self.mapView.addAnnotations(annots)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    @objc
    func searchStops() {
        delegate?.goToSearch()
    }
}

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // LocationAnnotation = MKPointAnnotation
        guard annotation is LocationAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            // MKPinAnnotationView: method of your map view delegate when you want to display a pin for one of your annotations
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.calloutOffset = CGPoint(x: -5, y: 5)
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            // annotationView!.image = UIImage(systemName: "pin")
        } else {
            annotationView!.annotation = annotation
            
        }
        
        return annotationView
    }
}
