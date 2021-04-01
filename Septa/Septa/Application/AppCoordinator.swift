//
//  AppCoordinator.swift
//  Septa
//
//  Created by Viviana Capolvenere on 18/02/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
        coordinators.append(homeCoordinator)
    }
}
