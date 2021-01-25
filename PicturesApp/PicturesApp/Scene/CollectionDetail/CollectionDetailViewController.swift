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
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    
    func createLayout() -> UICollectionViewLayout {
        
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

extension CollectionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.previewPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = photoCollection.dequeueReusableCell(for: indexPath)
        let photo = collection.previewPhotos[indexPath.item]
        cell.configure(withPhoto: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = collection.previewPhotos[indexPath.item]
        delegate?.onPhotoTap(photo: photo)
    }
}
