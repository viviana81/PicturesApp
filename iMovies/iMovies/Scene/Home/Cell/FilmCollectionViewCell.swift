//
//  FilmCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit
import Kingfisher

class FilmCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var filmImage: UIImageView!

    func configure(withFilmVM filmViewModel: FilmViewModel?) {
        
        filmImage.kf.setImage(with: filmViewModel?.posterURL)
    }
}
