//
//  ImagesCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 25/02/21.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var otherImage: UIImageView!
    
    func configure(withImage image: Image) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(image.path)")
        otherImage.kf.setImage(with: url)
    }
}
