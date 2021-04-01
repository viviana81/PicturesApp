//
//  HomeCoordinator.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 22/03/21.
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
    
    func searchByFilter(filter: Filter) {
        let searchVC = SearchViewController(filter: filter, viewModel: HomeViewModel())
        
        searchVC.onTapSearch = { [weak self] filterSearch in
            self?.homeVC.homeVM.searchJobs(withFilter: filterSearch)
          }
        
        navigation.present(UINavigationController(rootViewController: searchVC), animated: true, completion: nil)
    }
    
    func changeLayout() {
        
        homeVC.collectionLayout = homeVC.collectionLayout == .list ? .card : .list
    }
}
