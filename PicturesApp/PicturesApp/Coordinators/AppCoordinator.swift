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
        coordinators.removeAll()
        
        let homeCoordinator = HomeCoordinator(window: window, services: services)
        coordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
