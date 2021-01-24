//
//  ViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func getPhotos()
    func onPhotoTap(photo: Photo)
    func login()
    func logout()
    func viewProfile()
}

class HomeViewController: UIViewController {
    // MARK: - Vars
    enum State {
        case idle
        case loading
        case loaded(photos: [Photo])
        case error(error: Error)
    }
     
    var status: State = .idle {
        didSet {
            switch status {
            case .idle: break
            case .loading:
                loadingView.isHidden = false
            case .loaded(let photos):
                loadingView.isHidden = true
                self.photos = photos
            case .error(let error):
                showAlert(andMessage: error.localizedDescription)
            }
        }
    }
    
    lazy private var photoCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.register(PhotoCollectionViewCell.self)
        return collection
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
     weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - Lifecycle viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pictures"
        photoCollection.pin(to: view)
        loadingView.pin(to: view)
        delegate?.getPhotos()
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserStatus), name: Notification.Name("refreshUser"), object: nil)

        reloadButton()
    
    }
        
    // MARK: - Actions
    
    @objc func refreshUserStatus(_ notification: Notification) {
        reloadButton()
    }
    
    func reloadButton() {
        if let token = UserDefaultsConfig.token {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action: #selector(goToProfile))
            navigationItem.rightBarButtonItem!.tintColor = .white
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action: #selector(goToLogin))
            navigationItem.rightBarButtonItem!.tintColor = .white
        }
    }
    
    @objc
    func goToLogin() {
        delegate?.login()
      
    }
    
    @objc
    func goToProfile() {
        delegate?.viewProfile()
    }
    
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let photo = photos[indexPath.item]
        cell.configure(withPhoto: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == photos.count-1 {
          
            delegate?.getPhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        delegate?.onPhotoTap(photo: photo)
        
    }
}
