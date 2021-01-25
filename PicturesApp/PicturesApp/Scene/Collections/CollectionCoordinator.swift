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
    var collectionsViewController: CollectionsViewController
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        collectionsViewController = CollectionsViewController()
        navigation = CustomNavigationController(rootViewController: collectionsViewController)
        navigation.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "photo.on.rectangle"), tag: 3)
        // navigation.navigationItem.searchController = searchViewController.resultSearchController
        
    }
    
    func start() {
        collectionsViewController.delegate = self
    }
}

extension CollectionCoordinator: CollectionsViewControllerDelegate {
    
    func getCollections() {
        services.getCollections { [weak self] collections, error in
            if let collections = collections {
                self?.collectionsViewController.collections = collections
            } else {
                if let error = error {
                    self?.collectionsViewController.showAlert(andMessage: error.localizedDescription)
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
        self.collectionsViewController.present(photoDetail, animated: true, completion: nil)
    }
}
