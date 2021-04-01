//
//  OverviewCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 25/02/21.
//

import UIKit

class OverviewCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var overviewLabel: UILabel!
    
    func configure(withFilmVM viewModel: FilmViewModel?) {
        guard let viewModel = viewModel else { return }
        overviewLabel.text = viewModel.film.overview
    }
}
