//
//  QRCodeEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class QRCodeEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var realId: Int
    var width: Int
    var height: Int
    var link: String
    @Attribute(.externalStorage) var image: Data?
    
    init(realId: Int, width: Int, height: Int, link: String, image: Data? = nil) {
        self.realId = realId
        self.width = width
        self.height = height
        self.link = link
        self.image = image
    }
}
