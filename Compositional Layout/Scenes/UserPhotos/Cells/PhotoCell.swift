//
//  PhotoCell.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 25.04.2022.
//


import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var buttonFav: UIButton!
    let memberManager = MemberManager()
    
    struct ViewModel {
        let identifier: Int
        let imageURL: URL
    }

    var viewModel: ViewModel? {
        didSet {
			imageView.kf.cancelDownloadTask()
            imageView.kf.setImage(with: viewModel?.imageURL)
            buttonFav.isSelected = memberManager.isFavorite(photoId: viewModel?.identifier ?? 0)
        }
    }
    
    @IBAction func clickedFav(_ sender: Any) {
        if memberManager.isFavorite(photoId: viewModel?.identifier ?? 0) {
            memberManager.removePhotoFromFav(photoId: viewModel?.identifier ?? 0)
        } else {
            memberManager.addPhotoToFavorite(photoId: viewModel?.identifier ?? 0)
        }
        buttonFav.isSelected.toggle()
    }
    
}
