//
//  SearchViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 17/01/21.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func searchPhoto(withQuery query: String)
}

class SearchViewController: UIViewController {
    
    // MARK: Vars
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
    
    lazy private var photoCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.dataSource = self
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
        placeholder.isHidden = false
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

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        delegate?.searchPhoto(withQuery: text)
        placeholder.isHidden = true
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = photoCollection.dequeueReusableCell(for: indexPath)
        let photo = photos[indexPath.item]
        cell.configure(withPhoto: photo)
        return cell
    }
}
