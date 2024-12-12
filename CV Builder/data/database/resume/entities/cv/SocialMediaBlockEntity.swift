//
//  SocialMediaBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class SocialMediaBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [SocialMediaBlockItemEntity]?
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var styleIconAdded: Bool
    var styleHeaderPosition: Int

    init(list: [SocialMediaBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, styleIconAdded: Bool, styleHeaderPosition: Int) {
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.styleIconAdded = styleIconAdded
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: SocialMediaBlockEntity) {
        self.list = []
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.styleIconAdded = entity.styleIconAdded
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
}
