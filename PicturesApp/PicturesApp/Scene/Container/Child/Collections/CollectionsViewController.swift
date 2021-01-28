//
//  CollectionsViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 25/01/21.
//

import UIKit

protocol CollectionsViewControllerDelegate: class {
    func getCollections()
    func onCollectionTap(collection: Collection)
    
}

class CollectionsViewController: UIViewController {

    // MARK: - Vars
    lazy var folderCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        collection.register(FolderCollectionViewCell.self)
        return collection
    }()
    
    var collections: [Collection] = [] {
        didSet {
            folderCollection.reloadData()
        }
    }
    
    weak var delegate: CollectionsViewControllerDelegate?
    
    // MARK: - Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "mercury")
        folderCollection.pin(to: view, insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        delegate?.getCollections()
        
    }
    
    // MARK: - Actions
    
    func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(250))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)
        
        group.interItemSpacing = .fixed(CGFloat(20))
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CollectionsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FolderCollectionViewCell = folderCollection.dequeueReusableCell(for: indexPath)
        let collection = collections[indexPath.item]
        cell.configure(withCollection: collection)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collection = collections[indexPath.item]
        delegate?.onCollectionTap(collection: collection)
        
    }
}
