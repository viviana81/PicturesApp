//
//  AppCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.window = window
        self.services = services
    }
    
    func start() {
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .systemPink
        tabBarController.tabBar.barTintColor = .white
        
        let homeCoordinator = HomeCoordinator(window: window, services: services)
        let topicsCoordinator = TopicsCoordinator(window: window, services: services)
        let searchCoordinator = SearchCoordinator(window: window, services: services)
        let collectionsCoordinator = CollectionCoordinator(window: window, services: services)
        
        coordinators.append(homeCoordinator)
        coordinators.append(topicsCoordinator)
        coordinators.append(searchCoordinator)
        coordinators.append(collectionsCoordinator)
        
        tabBarController.viewControllers = [
            homeCoordinator.navigation,
            topicsCoordinator.navigation,
            searchCoordinator.navigation,
            collectionsCoordinator.navigation
        ]
        
        coordinators.forEach { $0.start() } // lanciamo tutti gli start dei coordinators
        window.rootViewController = tabBarController
        
    }
}
