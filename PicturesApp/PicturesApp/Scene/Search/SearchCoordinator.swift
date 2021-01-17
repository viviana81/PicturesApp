//
//  SearchCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 17/01/21.
//

import UIKit

class SearchCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let navigation: UINavigationController
    let searchViewController: SearchViewController
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        searchViewController = SearchViewController()
        navigation = UINavigationController(rootViewController: searchViewController)
        navigation.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
    }
    
    func start() {
        
    }
}
