//
//  DetailCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 24/01/21.
//

import UIKit
import Kingfisher

class DetailCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    private let photo: Photo
    let detailViewController: DetailViewController
    let navigation: UINavigationController
    
    init(navigation: UINavigationController, photo: Photo) {
        self.navigation = navigation
        self.photo = photo
        detailViewController = DetailViewController(photo: photo)
        
    }
    
    func start() {
        detailViewController.delegate = self
        navigation.pushViewController(detailViewController, animated: true)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func onTappedImage() {
        guard let url = URL(string: photo.urls.full) else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { (res) in
            
            switch res {
            case .success(let img):
                
                let imageDetail = ImageDetailViewController(image: img.image)
                imageDetail.modalPresentationStyle = .fullScreen
                self.detailViewController.present(imageDetail, animated: true, completion: nil)
            default:break
            }
        }
    }
    
    func onDowloadedImage() {
       
    }
    
    func onSavedImage() {
        
    }
}
