//
//  TopicsCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 17/01/21.
//

import UIKit

class TopicsCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let navigation: UINavigationController
    let topicsViewController: TopicsViewController
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        topicsViewController = TopicsViewController()
        navigation = UINavigationController(rootViewController: topicsViewController)
        navigation.tabBarItem = UITabBarItem(title: "Topics", image: UIImage(systemName: "list.bullet"), tag: 1)
    }
    
    func start() {
        
    }
}
