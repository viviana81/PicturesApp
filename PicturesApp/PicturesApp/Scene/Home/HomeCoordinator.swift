//
//  HomeCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let navigation: UINavigationController
    let homeViewController: HomeViewController
    let services: Services
    var page = 1
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        homeViewController = HomeViewController()
        navigation = CustomNavigationController(rootViewController: homeViewController)
        navigation.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
    }
    
    func start() {
        homeViewController.delegate = self
    
    }
}
extension HomeCoordinator: HomeViewControllerDelegate {
   
    func getPhotos() {
        services.getPhotos(page: page) { [ weak self ] (photos, error) in
            self?.page += 1
            if let photos = photos {
                self?.homeViewController.photos.append(contentsOf: photos)
            } else {
                if let error = error {
                    self?.homeViewController.showAlert(andMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func onPhotoTap(photo: Photo) {
        let detailCoordinator = DetailCoordinator(navigation: navigation, photo: photo)
        detailCoordinator.start()
        coordinators.append(detailCoordinator)
    }
    
    func login() {
        homeViewController.showAlert(withTitle: "Login", andMessage: "Vuoi effettuare il login", showCancel: true) {
              if let url = URL(string: "https://unsplash.com/oauth/authorize?client_id=bXdSj1vu0gOXPwaT7vDBDT1mWZF7CE9CYHHsqfj1O9k&redirect_uri=picturesapp:&response_type=code&scope=public") {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                self.homeViewController.showAlert(withTitle: "Complimenti", andMessage: "Hai appena effettuato l'accesso", showCancel: false, completion: nil)
              }
          }
    }
    
    func logout() {
        homeViewController.showAlert(withTitle: "Logout", andMessage: "Sei sicuro di volere effettuare il logout?", showCancel: true) {
            
            UserDefaultsConfig.token = nil
            self.homeViewController.reloadButton()
        }
    }
    
    func viewProfile() {
        let profileCoordinator = ProfileCoordinator(services: services, navigation: navigation)
        profileCoordinator.start()
        coordinators.append(profileCoordinator)
    }
}
