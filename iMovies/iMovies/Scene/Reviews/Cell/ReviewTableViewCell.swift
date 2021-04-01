//
//  ReviewTableViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 05/03/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    func configure(withReviewVM reviewVM: ReviewViewModel) {
       
        authorLabel?.text = reviewVM.author
        contentLabel.text = reviewVM.content
    }

}
