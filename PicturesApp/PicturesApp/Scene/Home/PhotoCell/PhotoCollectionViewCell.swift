//
//  PhotoCollectionViewCell.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var pictures: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // corrisponde al viewdidload
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(withPhoto photo: Photo) {
        let fullPictures = photo.urls.thumb
        if let url = URL(string: fullPictures) {
            pictures.kf.setImage(with: url)
        }
        if let description = photo.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "No description"
        }
        
        if let user = photo.user {
            nameLabel.text = user.name
        } else {
            nameLabel.text = "Anonimo"
        }
        
        if let color = photo.color {
            descriptionView.backgroundColor =  UIColor(hexFromString: color)
            descriptionView.isHidden = false
        } else {
            descriptionView.isHidden = true
        }
        
        let color = UIColor(hexFromString: photo.color ?? "")
        if color.isLight {
            descriptionLabel.textColor = UIColor.darkGray
            nameLabel.textColor = UIColor.darkGray
        } else {
            descriptionLabel.textColor = UIColor.white
            nameLabel.textColor = UIColor.white
        }
    }
}
