//
//  MemberManager.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation

class MemberManager {
    
    let defaults = UserDefaults.standard
    
    func setMemberFavorites(_ photos: [Int]) {
        return defaults.set(photos, forKey: DefaultsKeys.favorites.rawValue)
    }
    
    func getMemberFavorites() -> [Int] {
        return defaults.array(forKey: DefaultsKeys.favorites.rawValue) as? [Int] ?? [Int]()
    }
    
    func addPhotoToFavorite(photoId: Int) {
        var favorites = getMemberFavorites()
        favorites.append(photoId)
        setMemberFavorites(favorites)
    }
    
    func removePhotoFromFav(photoId: Int) {
        var favorites = getMemberFavorites()
        if let index = favorites.firstIndex(where: {$0 == photoId})
        {
            favorites.remove(at: index)
        }
        setMemberFavorites(favorites)
    }
    
    func isFavorite(photoId: Int) -> Bool {
        let favorites = getMemberFavorites()
        if favorites.contains(where: {$0 == photoId}) {
            return true
        } else {
            return false
        }
    }
    
    
    
}
