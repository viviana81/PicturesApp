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
    var page = 1
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        topicsViewController = TopicsViewController()
        navigation = CustomNavigationController(rootViewController: topicsViewController)
        navigation.tabBarItem = UITabBarItem(title: "Topics", image: UIImage(systemName: "list.bullet"), tag: 1)
    }
    
    func start() {
        topicsViewController.delegate = self
    }
}

extension TopicsCoordinator: TopicsViewControllerDelegate {
   
    func getTopics() {
        services.getTopics(page: page) { [ weak self ] topics, error in
            self?.page += 1
            if let topics = topics {
                self?.topicsViewController.topics.append(contentsOf: topics)
            } else {
                if let error = error {
                    self?.topicsViewController.showAlert(andMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func openDetail(photo: Photo) {
        let detailCoordinator = DetailCoordinator(presenter: topicsViewController, photo: photo, services: services)
        detailCoordinator.start()
        coordinators.append(detailCoordinator)
       
    }
}
