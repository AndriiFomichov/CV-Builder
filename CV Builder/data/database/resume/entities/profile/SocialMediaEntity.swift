//
//  SocialMediaEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class SocialMediaEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var link: String
    var media: Int
    var qrCodeId: Int
    
    var position: Int
    
    init(link: String, media: Int, qrCodeId: Int, position: Int) {
        self.link = link
        self.media = media
        self.qrCodeId = qrCodeId
        self.position = position
    }
}
