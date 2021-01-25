//
//  CollectionCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 25/01/21.
//

import UIKit

class CollectionCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let navigation: UINavigationController
    var collectionsViewController: CollectionsViewController
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        collectionsViewController = CollectionsViewController()
        navigation = CustomNavigationController(rootViewController: collectionsViewController)
        navigation.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "photo.on.rectangle"), tag: 2)
        // navigation.navigationItem.searchController = searchViewController.resultSearchController
        
    }
    
    func start() {
        
    }
}
