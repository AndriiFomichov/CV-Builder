//
//  InterestsBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class InterestsBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [InterestBlockItemEntity]?
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textInterests: String
    
    var styleIsBulletedList: Bool
    var styleIsChips: Bool
    var styleHeaderPosition: Int

    init(list: [InterestBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textInterests: String, styleIsBulletedList: Bool, styleIsChips: Bool, styleHeaderPosition: Int) {
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textInterests = textInterests
        self.styleIsBulletedList = styleIsBulletedList
        self.styleIsChips = styleIsChips
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: InterestsBlockEntity) {
        self.list = []
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textInterests = entity.textInterests
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleIsChips = entity.styleIsChips
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
}
