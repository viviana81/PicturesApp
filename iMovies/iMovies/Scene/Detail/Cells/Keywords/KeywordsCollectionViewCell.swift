//
//  KeywordsCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 26/02/21.
//

import UIKit

class KeywordsCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var keywordButton: UIButton!
    @IBOutlet weak var keywordCarousel: KeywordsCarousel!
    
    func configure(withViewModel viewModel: DetailViewModel) {
        keywordCarousel.keywords = viewModel.keywords 
    }
}
