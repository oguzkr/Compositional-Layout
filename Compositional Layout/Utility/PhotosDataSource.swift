//
//  PhotosDataSource.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 25.04.2022.
//

import UIKit

/// The data source associated with a list of photos.
class PhotosDataSource: NSObject {
	
	/// Represents a section in the data source.
	struct Section {
		
		/// Represents an item in the data source.
		struct Item {
			
			/// The unique identifier of the item.
			let identifier: Int
			
			/// The title associated with the item.
			let title: String
			
			/// The URL for the item’s thumbnail photo.
			let thumbnailUrl: URL
            
            let url: URL

		}
		
		/// The items that comprise the section.
		let items: [Item]
	}
	
	/// The sections that comprise the data source.
	let sections: [Section]
	
	/// Describes the ways that items can be distributed across sections.
	enum SectionStyle {
		
		/// Items are all found in one section.
		case single
		
		/// Items are distributed across multiple sections based on their album identifier.
        case byAlbum(maximumItemsPerAlbum: Int?, maximumNumberOfAlbums: Int?)
	}
	
	/// Creates a new instance of `PhotosDataSource`.
	/// - Parameter photos: The photo models that comprise the data source.
	/// - Parameter sectionStyle: How items are distributed across sections.
	init(photos: [Photo], sectionStyle: SectionStyle) {
		switch sectionStyle {
		case .single:
            self.sections = [Section(items: photos.map { Section.Item(identifier: $0.id, title: $0.title, thumbnailUrl: $0.thumbnailUrl, url: $0.url)})]
			
        case .byAlbum(let maximumItemsPerAlbum, let maximumNumberOfAlbums):
			var sectionNumberToItems: [Int: [Section.Item]] = [:]
			
			for photo in photos {
                let item = Section.Item(identifier: photo.id, title: photo.title, thumbnailUrl: photo.thumbnailUrl, url: photo.url)
				
				if let existingItems = sectionNumberToItems[photo.albumId] {
					sectionNumberToItems[photo.albumId] = existingItems + [item]
				} else {
					sectionNumberToItems[photo.albumId] = [item]
				}
			}
			
			let sortedKeys = sectionNumberToItems.keys.sorted()
			
			var sections: [Section] = []
            for key in Array(sortedKeys.prefix(maximumNumberOfAlbums ?? sortedKeys.count)) {
				guard let items = sectionNumberToItems[key] else { continue }
                sections.append(Section(items: Array(items.prefix(maximumItemsPerAlbum ?? items.count))))
			}
			
			self.sections = sections
		}
		super.init()
	}
}


