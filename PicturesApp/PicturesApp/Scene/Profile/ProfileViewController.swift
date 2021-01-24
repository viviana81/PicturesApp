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
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    weak var delegate: ProfileViewControllerDelegate?
    var currentUser: User? {
        didSet {
            guard let user = currentUser else { return }
            nameLabel.text = user.name
            firstNameLabel.text = user.firstName
            lastNameLabel.text = user.lastName
            usernameLabel.text = user.username
            if let image = URL(string:user.imageProfile.small) {
                userImage.kf.setImage(with: image)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        delegate?.getCurrentUser()
    }
}
