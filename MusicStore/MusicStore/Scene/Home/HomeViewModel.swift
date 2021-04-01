//
//  HomeViewModel.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation
import UIKit

class AlbumsViewModel {
    
    var albumsVM: [AlbumViewModel] = []
    let networkManager = NetworkManager()
    var onReloadData: (() -> Void)?
    
    var searchText: String?
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        return formatter
    }()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    func search(withQuery query: String) {
       
        guard let terms = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let urlString = "http://itunes.apple.com/search?term=\(terms))"
        
        guard let url = URL(string: urlString) else { return }
        
        networkManager.getData(from: url) { (data, error) in
            if let data = data,
               let searchedResp = try?
                self.decoder.decode(SearchedResponse<Album>.self, from: data) {
        
                    self.albumsVM = searchedResp.results.map { AlbumViewModel(album: $0) }
                    self.onReloadData?()
                
            } else if let error = error {
                print(error)
            } else {
                print("Non sono riuscito a convertire :(")
            }
        }
    }    
}

class AlbumViewModel {
    
    let album: Album
    
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
}
