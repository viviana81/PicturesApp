//
//  ProfileViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 24/01/21.
//

import UIKit
import Kingfisher

protocol ProfileViewControllerDelegate: class {
    func getCurrentUser()
    func goToLogout()
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    weak var delegate: ProfileViewControllerDelegate?
    var currentUser: User? {
        didSet {
            guard let user = currentUser else { return }
            nameLabel.text = user.name
            firstNameLabel.text = user.firstName
            lastNameLabel.text = user.lastName
            usernameLabel.text = user.username
            locationLabel.text = user.location
            if let image = URL(string: user.imageProfile.small) {
                userImage.kf.setImage(with: image)
                loadingView.isHidden = true
            }
        }
    }
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        delegate?.getCurrentUser()
        loadingView.isHidden = false
        loadingView.pin(to: view)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(logout))
    }
    
    // MARK: - Actions
    
    @objc
    func logout() {
        delegate?.goToLogout()
    }
}
