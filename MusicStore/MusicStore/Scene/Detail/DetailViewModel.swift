//
//  AlbumViewModel.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation
import UIKit
import AVKit

class DetailViewModel {
    
    private let album: Album
    
    deinit {
        player = nil
    }
    
    private lazy var player: AVPlayer? = {
        let player = AVPlayer(playerItem: AVPlayerItem(url: URL(string: album.sound)!))
        player.volume = 1.0
        return player
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    init(album: Album) {
        self.album = album
    }
    
    var artist: String {
        return album.artistName
    }
    
    var track: String {
        return album.trackName
    }
    
    var image: String {
        return album.image
    }
    
    var price: String {
        return "Prezzo album: \(String(album.collectionPrice))"
    }
    
    var date: String? {
        return "Data di uscita: \(formatter.string(from: album.releaseDate) )"
    }
    
    var bigImage: String {
        return album.biggerImage
    }
    
    func play() {
        player?.play()
    }
}
