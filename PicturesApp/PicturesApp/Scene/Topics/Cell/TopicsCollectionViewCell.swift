//
//  TopicsCollectionViewCell.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 18/01/21.
//

import UIKit
import Kingfisher

class TopicsCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var topicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(withTopic topic: Topic) {
        let photos = topic.previewPhotos
        if let photo = photos.first,
           let topicPhoto = URL(string: photo.urls.thumb) {
            topicImage.kf.setImage(with: topicPhoto)
        }
    }
}
