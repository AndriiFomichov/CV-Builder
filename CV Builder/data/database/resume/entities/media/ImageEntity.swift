//
//  ImageEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class ImageEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var realId: Int
    var width: Int
    var height: Int
    var isBackgroundRemoved: Bool
    var category: Int
    @Attribute(.externalStorage) var image: Data?
    
    init(realId: Int, width: Int, height: Int, isBackgroundRemoved: Bool, category: Int, image: Data? = nil) {
        self.realId = realId
        self.width = width
        self.height = height
        self.isBackgroundRemoved = isBackgroundRemoved
        self.category = category
        self.image = image
    }
}
