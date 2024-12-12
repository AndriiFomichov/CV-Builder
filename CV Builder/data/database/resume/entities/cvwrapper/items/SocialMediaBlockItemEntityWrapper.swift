//
//  SocialMediaBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class SocialMediaBlockItemEntityWrapper {
    
    var entity: SocialMediaBlockItemEntity?
    
    var link: String
    var media: Int
    var qrCodeId: Int
    var isAdded: Bool
    var position: Int
    var page: Int
    
    init(entity: SocialMediaBlockItemEntity?, link: String, media: Int, qrCodeId: Int, isAdded: Bool, position: Int, page: Int) {
        self.entity = entity
        self.link = link
        self.media = media
        self.qrCodeId = qrCodeId
        self.isAdded = isAdded
        self.position = position
        self.page = page
    }
    
    init(entity: SocialMediaBlockItemEntity) {
        self.entity = entity
        self.link = entity.link
        self.media = entity.media
        self.qrCodeId = entity.qrCodeId
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.page = entity.page
    }
    
    static func getDefault (position: Int) -> SocialMediaBlockItemEntityWrapper {
        return SocialMediaBlockItemEntityWrapper(entity: nil, link: position == 0 ? NSLocalizedString("dummy_social_page_one", comment: "") : NSLocalizedString("dummy_social_page_two", comment: ""), media: position, qrCodeId: -1, isAdded: true, position: position, page: 0)
    }
}
