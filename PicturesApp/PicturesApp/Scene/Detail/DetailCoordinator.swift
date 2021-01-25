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
    let services: Services
    
    init(navigation: UINavigationController, photo: Photo, services: Services) {
        self.navigation = navigation
        self.photo = photo
        self.services = services
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
    
    func onTapLike(onPhoto photo: Photo) {
        services.likePhoto(id: photo.id) { [weak self] res, error in
            if res {
                self?.detailViewController.showAlert(andMessage: "Hai aggiunto correttamento il tuo like a questa foto")
                self?.detailViewController.addLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self?.detailViewController.showAlert(andMessage: "Non hai aggiunto correttamente il tuo like a questa foto")
            }
        }
    }
}
