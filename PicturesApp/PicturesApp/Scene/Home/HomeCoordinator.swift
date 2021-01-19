//
//  HomeCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let navigation: UINavigationController
    let homeViewController: HomeViewController
    let services: Services
    var page = 1
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        homeViewController = HomeViewController()
        navigation = CustomNavigationController(rootViewController: homeViewController)
        navigation.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
    }
    
    func start() {
        homeViewController.delegate = self
    
    }
}
extension HomeCoordinator: HomeViewControllerDelegate {
    
    func getPhotos() {
        services.getPhotos(page: page) { [ weak self ] (photos, error) in
            self?.page += 1
            if let photos = photos {
                self?.homeViewController.photos.append(contentsOf: photos)
            } else {
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
