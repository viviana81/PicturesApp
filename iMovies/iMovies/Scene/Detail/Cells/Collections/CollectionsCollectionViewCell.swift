//
//  CollectionsCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 25/02/21.
//

import UIKit

class CollectionsCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(withSimilar similar: Film) {
       // guard let viewModel = viewModel else { return }
        titleLabel.text = similar.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(similar.poster)")
        filmImage.kf.setImage(with: url)
    }
    
    func configure(withRecomended recomended: Film) {
       // guard let viewModel = viewModel else { return }
        titleLabel.text = recomended.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(recomended.poster)")
        filmImage.kf.setImage(with: url)
    }
}
