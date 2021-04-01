//
//  AlbumTableViewCell.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import UIKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func configure(withAlbumVM album: AlbumViewModel) {
        titleLabel.text = album.track
        artistLabel.text = album.artist
        let url = URL(string: album.image)
        albumImage.kf.setImage(with: url)
    }
}
