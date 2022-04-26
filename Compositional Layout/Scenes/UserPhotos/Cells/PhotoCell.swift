//
//  PhotoCell.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 25.04.2022.
//


import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    
    struct ViewModel {
        let identifier: Int
        let imageURL: URL
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var viewModel: ViewModel? {
        didSet {
			imageView.kf.cancelDownloadTask()
            imageView.kf.setImage(with: viewModel?.imageURL)
        }
    }
}
