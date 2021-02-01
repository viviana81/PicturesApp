//
//  DetailCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 24/01/21.
//

import UIKit
import Kingfisher
import PromiseKit

class DetailCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    private let photo: Photo
    let detailViewController: DetailViewController
    // let navigation: UINavigationController
    private let presenter: UIViewController
    let services: Services
    var listCollection: MyCollectionListViewController?
    
    init(presenter: UIViewController, photo: Photo, services: Services) {
        self.presenter = presenter
        self.photo = photo
        self.services = services
        detailViewController = DetailViewController(photo: photo)
        
    }
    
    func start() {
        detailViewController.delegate = self
        presenter.present(detailViewController, animated: true, completion: nil)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    
    func onTappedImage() {
        guard let url = URL(string: photo.urls.full) else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { (res) in
            
            switch res {
            case .success(let img):
                
                let imageDetail = ImageDetailViewController(image: img.image)
                imageDetail.modalPresentationStyle = .fullScreen
                self.detailViewController.present(imageDetail, animated: true, completion: nil)
            default:break
            }
        }
    }
    
    func onTapLike(onPhoto photo: Photo) {
        services.likePhoto(id: photo.id) { [weak self] res, _ in
            if res {
                self?.detailViewController.showAlert(andMessage: "Hai aggiunto correttamento il tuo like a questa foto")
                self?.detailViewController.addLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self?.detailViewController.showAlert(andMessage: "Non hai aggiunto correttamente il tuo like a questa foto")
            }
        }
    }
    
    func onDeleteLike(onPhoto photo: Photo) {
        services.unlikePhoto(id: photo.id) { [weak self] res, _ in
            if res {
                self?.detailViewController.showAlert(andMessage: "Hai rimosso correttamento il tuo like a questa foto")
                self?.detailViewController.addLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self?.detailViewController.showAlert(andMessage: "Non hai rimosso correttamente il tuo like a questa foto")
            }
        }
    }
    
    func openCollections() {
        listCollection = MyCollectionListViewController()
        listCollection!.delegate = self
        detailViewController.present(listCollection!, animated: true, completion: nil)
    }
}

extension DetailCoordinator: MyCollectionListViewControllerDelegate {
    
    func getMyCollections() {
        firstly {
            getMe()
        }.then { user in
            self.getUserCollections(username: user.username)
        }.done { collections in
            self.listCollection?.collections = collections
        }.catch { error in
            self.listCollection?.showAlert(andMessage: error.localizedDescription)
        }
    }
    
    func getMe() -> Promise<User> {
        return Promise<User> { seal in
            
            services.getMe { (user, error) in
                if let user = user {
                    seal.fulfill(user)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func getUserCollections(username: String) -> Promise<[Collection]> {
        return Promise<[Collection]> { seal in
            
            services.getUserCollections(username: username) { (collections, error) in
                if let collections = collections {
                    seal.fulfill(collections)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }

    func addToCollection(_ collection: Collection) {
        services.addPhotoToCollection(idPhoto: photo.id, idCollection: collection.id) { [weak self] res, _ in
            if res {
                self?.listCollection?.showAlert(andMessage: "Hai aggiunto correttamente la foto alla collezione")
            } else {
                self?.listCollection?.showAlert(andMessage: "La foto non è stata aggiunta correttamente")
            }
        }
    }
}
