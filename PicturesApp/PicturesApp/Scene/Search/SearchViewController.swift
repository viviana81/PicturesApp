//
//  SearchViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 17/01/21.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func searchPhoto(withQuery query: String)
    func openDetail(searchedPhoto: Photo)
}

class SearchViewController: UIViewController {
    
    // MARK: Vars
    enum State {
        case idle
        case searching
        case searched(photos: [Photo])
        case error(error: Error)
    }
    var status: State = .idle {
        didSet {
            switch status {
            case .idle:
                placeholder.isHidden = false
                photoCollection.isHidden = true
            case .searching:
                loadingView.isHidden = false
            case .searched(let photos):
                self.photos = photos
                placeholder.isHidden = true
                loadingView.isHidden = true
                photoCollection.isHidden = false
            case .error(let error):
                showAlert(andMessage: error.localizedDescription)
            }
        }
    }
    lazy var resultSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        controller.searchBar.tintColor = .white
        controller.searchBar.placeholder = "Search"
        controller.searchBar.textColor = .white
        controller.searchBar.delegate = self
        return controller
    }()
    
    lazy private var photoCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.register(PhotoCollectionViewCell.self)
        return collection
    }()
    
    lazy private var placeholder: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "mercury")
        return image
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    var photos: [Photo] = [] {
        didSet {
            photoCollection.reloadData()
        }
    }
    
    weak var delegate: SearchViewControllerDelegate?
    
    // MARK: - Lifecycle viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
    
        photoCollection.pin(to: view)
        placeholder.pin(to: view, insets: UIEdgeInsets(top: 60, left: 40, bottom: 60, right: 40))
        loadingView.pin(to: view)
        placeholder.isHidden = false
        loadingView.isHidden = true
        self.navigationItem.titleView = resultSearchController.searchBar
    }
    
    // MARK: - Actions
    
    func createLayout() -> UICollectionViewLayout {
        
        // let numberOfItemsInRow = UIDevice.current.userInterfaceIdiom == .pad ? 3 : 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(150))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 2)
        
        group.interItemSpacing = .fixed(CGFloat(10))
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        delegate?.searchPhoto(withQuery: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        status = .idle
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = photoCollection.dequeueReusableCell(for: indexPath)
        let photo = photos[indexPath.item]
        cell.configure(withPhoto: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchedPhoto = photos[indexPath.item]
        delegate?.openDetail(searchedPhoto: searchedPhoto)
    }
}
