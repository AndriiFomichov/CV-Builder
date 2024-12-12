//
//  SocialMediaItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation
import UIKit

class SocialMediaItem {
    
    var entity: SocialMediaEntity
    
    var link: String
    var media: Int
    var qrCodeId: Int
    
    var position: Int
    
    var qrCodePreview: UIImage?
    
    init(entity: SocialMediaEntity, qrCodePreview: UIImage?) {
        self.entity = entity
        self.link = entity.link
        self.media = entity.media
        self.qrCodeId = entity.qrCodeId
        self.position = entity.position
        self.qrCodePreview = qrCodePreview
    }
    
    static func getDefault () -> SocialMediaItem {
        return SocialMediaItem(entity: SocialMediaEntity(link: "", media: 0, qrCodeId: -1, position: 0), qrCodePreview: nil)
    }
}
