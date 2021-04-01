//
//  ReviewViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 05/03/21.
//

import Foundation

class ReviewViewModel {
    
    let review: Review
    
    init(review: Review) {
        self.review = review
    }
    
    var author: String {
        "Written by \(review.author)"
    }
    
    var content: String {
        review.content
    }
}
