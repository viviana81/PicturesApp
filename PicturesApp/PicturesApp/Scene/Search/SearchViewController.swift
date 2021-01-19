//
//  SearchViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 17/01/21.
//

import UIKit

class SearchViewController: UIViewController {

    lazy var resultSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        controller.searchBar.tintColor = .white
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = resultSearchController.searchBar
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
