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
    @IBOutlet weak var removeButton: UIButton!
    var onTapButton: (() -> Void)?
        
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func configure(withCollection collection: Collection) {
        removeButton.isHidden = true
        titleCollection.text = collection.title
        if let curl = collection.cover, let cover = URL(string: curl.urls.regular) {
            coverImage.kf.setImage(with: cover)
        } else {
            coverImage.image = UIImage(named: "placeholder")
        }
    }
    
    func configureUserFolder(withCollection collection: Collection) {
        removeButton.isHidden = false
        titleCollection.text = collection.title
        if let curl = collection.cover, let cover = URL(string: curl.urls.regular) {
            coverImage.kf.setImage(with: cover)
        } else {
            coverImage.image = UIImage(named: "placeholder")
        }
    }
    
    @IBAction func removeCollection(_ sender: UIButton) {
        onTapButton?()
    }
}
