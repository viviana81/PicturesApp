//
//  ProfileCoordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 24/01/21.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigation: UINavigationController
    let services: Services
    private let profileViewController: ProfileViewController
    
    init(services: Services, navigation: UINavigationController) {
        self.profileViewController = ProfileViewController()
        self.navigation = navigation
        self.services = services
    }
    
    func start() {
        
        profileViewController.delegate = self
        navigation.pushViewController(profileViewController, animated: true)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func getCurrentUser() {
        services.getMe { [weak self] user, error in
            if let user = user {
                self?.profileViewController.currentUser = user
            }
        }
    }
}
