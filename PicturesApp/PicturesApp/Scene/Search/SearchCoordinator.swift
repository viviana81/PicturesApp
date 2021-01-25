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
    var searchViewController: SearchViewController
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        searchViewController = SearchViewController()
        navigation = CustomNavigationController(rootViewController: searchViewController)
        navigation.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        // navigation.navigationItem.searchController = searchViewController.resultSearchController
        
    }
    
    func start() {
        searchViewController.delegate = self
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    
    func searchPhoto(withQuery query: String) {
        searchViewController.status = .searching
        services.search(query: query) { [weak self] searchedResp, error in
            if let searchedResp = searchedResp {
                self?.searchViewController.status = .searched(photos: searchedResp.results)
            } else {
                if let error = error {
                    self?.searchViewController.status = .error(error: error)
                }
            }
        }
    }
    
    func openDetail(searchedPhoto: Photo) {
        let detail = DetailViewController(photo: searchedPhoto)
        self.searchViewController.present(detail, animated: true, completion: nil)
    }
}
