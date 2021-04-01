//
//  ReviewsCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var reviewsLabel: UILabel!
    
    func configure(withReviews reviews: [Review]) {
        reviewsLabel.text =  "\(reviews.count) reviews"
    }
}
