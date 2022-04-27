//
//  UserDetailVC.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import UIKit
import Kingfisher

class UserDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bind(_ photoURL: URL, _ user: User){
        nameLabel.text = user.name
        imageView.kf.setImage(with: photoURL)
    }

    @IBAction func clickedDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clickedFav(_ sender: Any) {
        favButton.isSelected.toggle()
    }
}
