//
//  CollectionDetailViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 25/01/21.
//

import UIKit

protocol CollectionDetailViewControllerDelegate: class {
    func onPhotoTap(photo: Photo)
}

class CollectionDetailViewController: UIViewController {

    // MARK: - Vars
    lazy var photoCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.register(PhotoCollectionViewCell.self)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    weak var delegate: CollectionDetailViewControllerDelegate?
    
    private let collection: Collection
    
    init(collection: Collection) {
        self.collection = collection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewcontroller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollection.pin(to: view)
        view.backgroundColor = UIColor(named: "mercury")
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
        
        group.interItemSpacing = .fixed(CGFloat(10))
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CollectionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.previewPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionsPhotos = collection.previewPhotos else { fatalError("Invalid")}
        
        let cell: PhotoCollectionViewCell = photoCollection.dequeueReusableCell(for: indexPath)
        let photo = collectionsPhotos[indexPath.item]
        cell.configure(withPhoto: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = collection.previewPhotos?[indexPath.item] else { return }
        delegate?.onPhotoTap(photo: photo)
    }
}
