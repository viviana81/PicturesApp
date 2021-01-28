//
//  FolderCollectionViewCell.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 25/01/21.
//

import UIKit
import Kingfisher

class FolderCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var titleCollection: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
        
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func configure(withCollection collection: Collection) {
        titleCollection.text = collection.title
        if let curl = collection.cover, let cover = URL(string: curl.urls.regular) {
            coverImage.kf.setImage(with: cover)
        } else {
            coverImage.image = UIImage(named: "placeholder")
        }
    }
}
