//
//  AppCoordinator.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation
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
