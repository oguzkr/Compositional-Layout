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
    
    struct ViewModel {
        let identifier: Int
        let imageURL: URL
    }

    var viewModel: ViewModel? {
        didSet {
			imageView.kf.cancelDownloadTask()
            imageView.kf.setImage(with: viewModel?.imageURL)
        }
    }
    
    @IBAction func clickedFav(_ sender: Any) {
        
    }
    
}
