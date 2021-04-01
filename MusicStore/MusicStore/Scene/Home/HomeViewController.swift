//
//  HomeViewController.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func goToDetail(albumVM: AlbumViewModel)
}

class HomeViewController: UIViewController {

    // MARK: - Vars
    lazy var resultSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        // controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        controller.searchBar.tintColor = .white
        controller.searchBar.placeholder = "Search"
        // controller.searchBar.textColor = .white
        controller.searchBar.delegate = self
        return controller
        
    }()
    
    lazy private var placeholder: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "music.house"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.systemIndigo
        return image
    }()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AlbumTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    let viewModel: AlbumsViewModel
    
    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.pin(to: view)
        tableView.isHidden = true
        placeholder.pin(to: view, insets: UIEdgeInsets(top: 60, left: 40, bottom: 60, right: 40))
        placeholder.isHidden = false
        self.navigationItem.titleView = resultSearchController.searchBar
        viewModel.onReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
   
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        viewModel.search(withQuery: text)
        tableView.isHidden = false
        placeholder.isHidden = true
        resultSearchController.isActive = false
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let albumVM = viewModel.albumsVM[indexPath.row]
        cell.configure(withAlbumVM: albumVM)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumVM = viewModel.albumsVM[indexPath.row]
        delegate?.goToDetail(albumVM: albumVM)
        
    }
}
