//
//  UserDetailViewModel.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation

class UserDetailViewModel {
    
    let network = ApiClient()
    var photos = [Photo]()
    
    func fetchPhotoDetail(albumId: Int, completed: @escaping(Bool) -> Void) {
        network.getPhotos(albumId: albumId) { result, success in
            if let result = result {
                self.photos = result
            }
            completed(success)
        }
    }
    
}
