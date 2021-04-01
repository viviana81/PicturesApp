//
//  FilmListTableViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import UIKit
import Kingfisher

class FilmListTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    func configure(withFilm film: FilmViewModel?) {
        guard let film = film else { return }
        titleLabel.text = film.title
        voteLabel.text = film.vote
        dateLabel.text = film.date
        descriptionLabel.text = film.description
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.poster)")
        filmImage.kf.setImage(with: url)
    }
   
}
