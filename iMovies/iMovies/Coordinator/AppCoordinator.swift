//
//  AppCoordinator.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .orange
        
        let homeCoordinator = HomeCoordinator(window: window)
        let listCoordinator = ListCoordinator(window: window)
        
        coordinators.append(homeCoordinator)
        coordinators.append(listCoordinator)
        
        tabBarController.viewControllers = [
            homeCoordinator.navigation,
            listCoordinator.navigation
        ]
        
        coordinators.forEach { $0.start() }
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

    }
}
