//
//  UserDetailVC.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import UIKit
import Kingfisher

protocol UpdateFavoriteDelegate {
    func updateFavStatus()
}

class UserDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var photo: Photo?
    let memberManager = MemberManager()
    var delegate: UpdateFavoriteDelegate? = nil

    func bind(_ photo: Photo, _ user: User, thumbnail: Bool){
        self.photo = photo
        nameLabel.text = user.name
        if thumbnail {
            imageView.kf.setImage(with: photo.thumbnailUrl)
        } else {
            imageView.kf.setImage(with: photo.url)
        }
        favButton.isSelected = memberManager.isFavorite(photoId: photo.id)
    }
    
    @IBAction func clickedFav(_ sender: Any) {
        if let photo = self.photo {
            if memberManager.isFavorite(photoId: photo.id) {
                memberManager.removePhotoFromFav(photoId: photo.id)
            } else {
                memberManager.addPhotoToFavorite(photoId: photo.id)
            }
            favButton.isSelected.toggle()
            delegate?.updateFavStatus()
        }
    }
    
    @IBAction func clickedDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
