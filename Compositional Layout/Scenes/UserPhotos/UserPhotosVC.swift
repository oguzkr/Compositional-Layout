//
//  ViewController.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 25.04.2022.
//

import UIKit
import ProgressHUD

class UserPhotosVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = UserPhotosViewModel()
    var users = [User]()
    var photos = [Photo]()
    var dataSource: PhotosDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        bindData()
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
    }
    
    func configureCollectionView(){
        self.dataSource = PhotosDataSource(photos: self.photos, sectionStyle: .byAlbum(maximumItemsPerAlbum: nil, maximumNumberOfAlbums: nil))
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = self.collectionViewLayout()
        self.collectionView.reloadData()
    }
    
    func bindData(){
        ProgressHUD.show()
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.2740042928, green: 0.6571566977, blue: 1, alpha: 1)
        viewModel.fetchUsers { success in
            if success {
                for user in self.viewModel.users {
                    guard let userId = user.id else { return }
                    self.viewModel.fetchAlbums(userId: userId) { success in
                        self.users.insert(contentsOf: self.viewModel.users, at: 0)
                        for album in self.viewModel.albums {
                            guard let albumId = album.id else { return }
                            self.viewModel.fetchPhotos(albumId: albumId) { success in
                                if success {
                                    self.photos.insert(contentsOf: self.viewModel.photos, at: 0)
                                    if self.loadingFinished() {
                                        self.configureCollectionView()
                                        ProgressHUD.dismiss()
                                    }
                                } else {
                                    self.showAlert(titleInput: "Success", messageInput: "Task failed successfully.")
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let inset: CGFloat = 2.5
            
            let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
            largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
            smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
            
            let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
            let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
            
            let section = NSCollectionLayoutSection(group: outerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            section.orthogonalScrollingBehavior = .groupPaging
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
            section.boundarySupplementaryItems = [headerItem]
            
            return UICollectionViewCompositionalLayout(section: section)
        }()
        return compositionalLayout
    }
    
    
    func loadingFinished() -> Bool {
        if self.photos.count == (self.viewModel.photos.count * self.viewModel.albums.count  * self.viewModel.users.count) {
            return true
        } else {
            return false
        }
    }
    
}

extension UserPhotosVC: UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let count = dataSource?.sections.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = dataSource?.sections[section].items.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
             return UICollectionViewCell()
        }
        if let photo = dataSource?.sections[indexPath.section].items[indexPath.item] {
            if indexPath.row % 5 != 0  {
                cell.viewModel = PhotoCell.ViewModel(identifier: photo.identifier, imageURL: photo.thumbnailUrl)
            } else {
                cell.viewModel = PhotoCell.ViewModel(identifier: photo.identifier, imageURL: photo.url)

            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photo = dataSource?.sections[indexPath.section].items[indexPath.item] {
            print("PHOTO", photo)
        }
        print("USER", self.users[indexPath.section])
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case "header":
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as? HeaderSupplementaryView else {
                return HeaderSupplementaryView()
            }
            if let userName = self.users[indexPath.section].name {
                headerView.viewModel = HeaderSupplementaryView.ViewModel(title: userName)
            } else {
                headerView.viewModel = HeaderSupplementaryView.ViewModel(title: "Section \(indexPath.section + 1)")
            }
            
            return headerView
            
        case "new-banner":
            let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewBannerSupplementaryView", for: indexPath)
            bannerView.isHidden = indexPath.row % 5 != 0 // show on every 5th item
            return bannerView
            
        default:
            assertionFailure("Unexpected element kind: \(kind).")
            return UICollectionReusableView()
        }
    }
}
