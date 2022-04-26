//
//  Album.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation

// MARK: - Album
struct Album: Decodable {
    let userId, id: Int?
    let title: String?
}

