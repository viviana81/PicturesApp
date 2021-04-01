//
//  HomeCoordinator.swift
//  Septa
//
//  Created by Viviana Capolvenere on 18/02/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let homeVC: HomeViewController
    let navigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        homeVC = HomeViewController(homeVM: HomeViewModel())
        navigation = UINavigationController(rootViewController: homeVC)
    }
    
    func start() {
        homeVC.delegate = self
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
extension HomeCoordinator: HomeViewControllerDelegate {
    func goToSearch() {
        let stopsCoordinator = StopsCoordinator(presenter: homeVC)
        stopsCoordinator.start()
        coordinators.append(stopsCoordinator)
    }
}
