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
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        homeViewController = HomeViewController()
        navigation = UINavigationController(rootViewController: homeViewController)
    }
    
    func start() {
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
