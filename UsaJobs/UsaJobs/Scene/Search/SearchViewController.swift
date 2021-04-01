//
//  SearchViewController.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 29/03/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var onTapSearch: ((FilterSearch) -> Void)?

    private let filter: Filter
    private let viewModel: HomeViewModel
    
    init(filter: Filter, viewModel: HomeViewModel) {
        self.filter = filter
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var resultSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        // controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        controller.searchBar.tintColor = .white
        controller.searchBar.placeholder = "Search by \(filter.title)"
        // controller.searchBar.textColor = .white
        controller.searchBar.delegate = self
        return controller
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = resultSearchController.searchBar
        if filter == .travelPercentage || filter == .positionScheduleTypeCode {
            tableView.isHidden = false
            titleLabel.isHidden = false
        } else {
            tableView.isHidden = true
            titleLabel.isHidden = true
        }
    }
    
  /*  @IBAction func search() {
        guard let text = resultSearchController.searchBar.text, !text.isEmpty else { return }
        viewModel.searchJobs(withQuery: text)
        self.dismiss(animated: true, completion: nil)
    }*/
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        let filterSearch = FilterSearch(key: filter.key, value: text)
        self.onTapSearch?(filterSearch)
        resultSearchController.isActive = false
        self.dismiss(animated: true, completion: nil)
    }
}
