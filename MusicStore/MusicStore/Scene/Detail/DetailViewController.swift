//
//  DetailViewController.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let detailViewModel: DetailViewModel
    
    init(detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = detailViewModel.track
        artistLabel.text = detailViewModel.artist
        priceLabel.text = detailViewModel.price
        dateLabel.text = detailViewModel.date
        
        let url = URL(string: detailViewModel.bigImage)
        albumImage.kf.setImage(with: url)
    }
    
    @IBAction func playTrack() {
        detailViewModel.play()
    }
}
