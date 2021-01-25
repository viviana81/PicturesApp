//
//  Services.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import Foundation

protocol Services {
    
    func getPhotos(page: Int, completion: @escaping([Photo]?, Error?) -> Void)
    func getTopics(page: Int, completion: @escaping([Topic]?, Error?) -> Void)
    func search(query: String, completion: @escaping(SearchedResponse<Photo>?, Error?) -> Void)
    func getToken(code: String, completion: @escaping(Token?, Error?) -> Void)
    func getMe(completion: @escaping(User?, Error?) -> Void)
    func likePhoto(id: String, completion: @escaping(Bool, Error?) -> Void)
}
