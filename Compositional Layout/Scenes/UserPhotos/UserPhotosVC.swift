//
//  ViewController.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 25.04.2022.
//

import UIKit

class UserPhotosVC: UIViewController {

    let viewModel = UserPhotosViewModel()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUsers { success in
            success ? print(self.viewModel.users) : self.showAlert(titleInput: "Success", messageInput: "Task failed successfully.")
        }
        
        viewModel.fetchAlbums(userId: 2) { success in
            success ? print(self.viewModel.albums) : self.showAlert(titleInput: "Success", messageInput: "Task failed successfully.")
        }
        
        viewModel.fetchPhotos(albumId: 11) { success in
            success ? print(self.viewModel.photos) : self.showAlert(titleInput: "Success", messageInput: "Task failed successfully.")
        }
    }


}

