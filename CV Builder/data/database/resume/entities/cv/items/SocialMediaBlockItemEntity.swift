//
//  SocialMediaBlockItemEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class SocialMediaBlockItemEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var entityId: String
    var link: String
    var media: Int
    var qrCodeId: Int
    var isAdded: Bool
    var position: Int
    var page: Int
    
    init(entityId: String, link: String, media: Int, qrCodeId: Int, isAdded: Bool, position: Int, page: Int) {
        self.entityId = entityId
        self.link = link
        self.media = media
        self.qrCodeId = qrCodeId
        self.isAdded = isAdded
        self.position = position
        self.page = page
    }
    
    init(entity: SocialMediaBlockItemEntity) {
        self.entityId = entity.entityId
        self.link = entity.link
        self.media = entity.media
        self.qrCodeId = entity.qrCodeId
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.page = entity.page
    }
}
