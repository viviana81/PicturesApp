//
//  TopicsViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 17/01/21.
//

import UIKit

protocol TopicsViewControllerDelegate: class {
    func getTopics()
}

class TopicsViewController: UIViewController {

    // MARK: - Vars
    lazy var topicsCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.register(TopicsCollectionViewCell.self)
        collection.dataSource = self
        return collection
    }()
    
    var topics: [Topic] = [] {
        didSet {
            topicsCollection.reloadData()
        }
    }
    
    var delegate: TopicsViewControllerDelegate?
    
    // MARK: - Lifecycle viewcontroller
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topicsCollection.pin(to: view)
        delegate?.getTopics()
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

extension TopicsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TopicsCollectionViewCell = topicsCollection.dequeueReusableCell(for: indexPath)
        let topic = topics[indexPath.item]
        cell.configure(withTopic: topic)
        return cell
    }
}
