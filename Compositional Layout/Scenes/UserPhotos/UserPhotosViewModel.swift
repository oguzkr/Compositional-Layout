//
//  UserPhotosViewModel.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation

class UserPhotosViewModel {
    
    let Client = ApiClient()
    
    var users = [User]()
    var photos = [Photo]()
    var albums = [Album]()
    
    func fetchUsers(completed: @escaping(Bool) -> Void) {
        Client.getUsers { result, success in
            if let result = result {
                self.users = result
            }
            completed(success)
        }
    }
    
    func fetchPhotos(albumId: Int, completed: @escaping(Bool) -> Void) {
        Client.getPhotos(albumId: albumId) { result, success in
            if let result = result {
                self.photos = result
            }
            completed(success)
        }
    }
    
    func fetchAlbums(userId: Int, completed: @escaping(Bool) -> Void) {
        Client.getAlbum(userId: userId) { result, success in
            if let result = result {
                self.albums = result
            }
            completed(success)
        }
    }
    
}
