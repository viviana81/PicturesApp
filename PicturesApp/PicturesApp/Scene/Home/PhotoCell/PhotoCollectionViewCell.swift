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
    
    // corrisponde al viewdidload
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configure(withPhoto photo: Photo) {
        let fullPictures = photo.urls.thumb
        if let url = URL(string: fullPictures) {
            pictures.kf.setImage(with: url)
        }
    }
}
