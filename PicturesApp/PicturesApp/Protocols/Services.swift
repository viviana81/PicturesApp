//
//  Services.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import Foundation

protocol Services {
    
    func getPhotos(page: Int, completion: @escaping([Photo]?, Error?) -> Void)
}
