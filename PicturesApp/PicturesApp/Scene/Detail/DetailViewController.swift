//
//  DetailViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 19/01/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: - Vars
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Viewcontroller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageProfile = URL(string: photo.user?.imageProfile.small ?? "") {
            userImage.kf.setImage(with: imageProfile)
        }
        
        if let color = photo.color {
            view.backgroundColor = UIColor(hexFromString: color)
        }
        if let photo = URL(string: photo.urls.regular) {
            photoImage.kf.setImage(with: photo, placeholder: UIImage(named: "placeholder"))
        }
        
        userLabel.text = photo.user?.name
        userLocation.text = photo.user?.location
        descriptionLabel.isHidden = false
        descriptionTitleLabel.isHidden = false
        
        if let description = photo.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "No description"
        }
        
        let color = UIColor(hexFromString: photo.color ?? "")
        if color.isLight {
            descriptionLabel.textColor = UIColor.darkGray
            userLabel.textColor = UIColor.darkGray
            userLocation.textColor = UIColor.darkGray
            downloadButton.tintColor = UIColor.darkGray
            descriptionTitleLabel.textColor = UIColor.darkGray
        } else {
            descriptionLabel.textColor = UIColor.white
            userLabel.textColor = UIColor.white
            userLocation.textColor = UIColor.white
            downloadButton.tintColor = UIColor.white
            descriptionTitleLabel.textColor = UIColor.white
            // likesLabel.textColor = UIColor.white
        }
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.onImageTap(_:)))
        photoImage.addGestureRecognizer(imageTap)
        photoImage.isUserInteractionEnabled = true
    }
    
    @objc
    func onImageTap(_ recognizer: UIGestureRecognizer) {
        print("tapped")
    }
}
