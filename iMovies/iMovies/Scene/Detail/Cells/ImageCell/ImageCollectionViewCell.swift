//
//  ImageCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageFilm: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var genresCarousel: GenresCarousel!
    
    func configure(withFilmVM viewModel: FilmViewModel?) {
        guard let viewModel = viewModel else { return }
        voteLabel.text = viewModel.detailVote
        detailLabel.text = viewModel.detail
        imageFilm.kf.setImage(with: viewModel.posterURL)
        background.kf.setImage(with: viewModel.backgroundURL)
        
        background.frame = self.bounds
        background.contentMode = .scaleToFill
        genresCarousel.genres = viewModel.film.genres ?? []
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = background.bounds
        background.addSubview(blurredEffectView)
        
    }
}
