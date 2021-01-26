//
//  CollectionCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 25/01/21.
//

import UIKit

class CollectionCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let navigation: UINavigationController
    let containerViewController: ContainerViewController
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        containerViewController = ContainerViewController()
        navigation = CustomNavigationController(rootViewController: containerViewController)
        navigation.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "photo.on.rectangle"), tag: 3)
        
    }
    
    func start() {
        containerViewController.firstChild.delegate = self
        
    }
}

extension CollectionCoordinator: CollectionsViewControllerDelegate {
   
    func getCollections() {
        services.getCollections { [weak self] collections, error in
            if let collections = collections {
                self?.containerViewController.firstChild.collections = collections
            } else {
                if let error = error {
                    self?.containerViewController.firstChild.showAlert(andMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func onCollectionTap(collection: Collection) {
        let collectionDetail = CollectionDetailViewController(collection: collection)
        collectionDetail.delegate = self
        navigation.pushViewController(collectionDetail, animated: true)
    }
}

extension CollectionCoordinator: CollectionDetailViewControllerDelegate {
    func onPhotoTap(photo: Photo) {
        let photoDetail = DetailViewController(photo: photo)
        self.containerViewController.firstChild.present(photoDetail, animated: true, completion: nil)
    }
}
