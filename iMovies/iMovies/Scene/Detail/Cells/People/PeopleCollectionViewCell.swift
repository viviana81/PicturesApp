//
//  PeopleCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 01/03/21.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var peopleImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(withPeopleCast people: PeopleCast) {
        
        nameLabel.text = people.name
        descriptionLabel.text = people.character
        if let path = people.image, let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {
            peopleImage.kf.setImage(with: url)
        }
    }
    
    func configure(withPeopleCrew people: PeopleCrew) {
        
        nameLabel.text = people.name
        descriptionLabel.text = people.department
        if let path = people.image, let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {
            peopleImage.kf.setImage(with: url)
        }
    }
}
