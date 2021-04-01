//
//  HomeCoordinator.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let homeVC: HomeViewController
    let navigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        homeVC = HomeViewController(viewModel: AlbumsViewModel())
        navigation = UINavigationController(rootViewController: homeVC)
    }
    
    func start() {
        homeVC.delegate = self
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func goToDetail(albumVM: AlbumViewModel) {
        let detailCoordinator = DetailCoordinator(album: albumVM.album, presenter: homeVC)
        detailCoordinator.start()
        coordinators.append(detailCoordinator)
        // per evitare il retain cycle
        detailCoordinator.onDismiss = { [weak self] in
            self?.coordinators.removeAll { $0 is DetailCoordinator  }
        }
    }
}
