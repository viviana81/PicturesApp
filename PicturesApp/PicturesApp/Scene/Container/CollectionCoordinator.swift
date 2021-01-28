//
//  CollectionCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 25/01/21.
//

import UIKit
import PromiseKit

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
        containerViewController.secondChild.delegate = self
        containerViewController.delegate = self
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

extension CollectionCoordinator: ContainerViewControllerDelegate {
    func onTapNewCollection() {
        let addCollection = AddCollectionViewController()
        addCollection.delegate = self
        navigation.pushViewController(addCollection, animated: true)
    }
}

extension CollectionCoordinator: AddCollectionViewControllerDelegate {
    func onTapAdd(title: String, description: String, privacy: Bool) {
        services.addCollection(title: title, description: description, privacy: privacy) { [weak self] res, _ in
            if res {
                self?.containerViewController.showAlert(andMessage: "Hai aggiunto correttamente la tua raccolta")
            } else {
                self?.containerViewController.showAlert(andMessage: "Non hai aggiunto correttamente la tua raccolta")
            }
        }
    }
}
extension CollectionCoordinator: MyCollectionViewControllerDelegate {
    func getMyCollections() {
        
        firstly {
            getMe()
        }.then { user in
            self.getUserCollections(username: user.username)
        }.done { collections in
            self.containerViewController.secondChild.collections = collections
        }.catch { error in
            
        }
    }
    
    func getMe() -> Promise<User> {
        return Promise<User> { seal in
            
            services.getMe { (user, error) in
                if let user = user {
                    seal.fulfill(user)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func getUserCollections(username: String) -> Promise<[Collection]> {
        return Promise<[Collection]> { seal in
            
            services.getUserCollections(username: username) { (collections, error) in
                if let collections = collections {
                    seal.fulfill(collections)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
}
