//
//  Photos.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation

// MARK: - Photos
struct Photos: Codable {
    let albumId, id: Int?
    let title: String?
    let url, thumbnailUrl: String?
}
