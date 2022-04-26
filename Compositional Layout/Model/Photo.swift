//
//  Photos.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//


import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
