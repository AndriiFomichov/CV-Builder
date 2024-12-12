//
//  SkillsBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class SkillsBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [SkillBlockItemEntity]?
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textSkills: String
    
    var styleIsBulletedList: Bool
    var styleIsChips: Bool
    var styleIsProgressAdded: Bool
    var styleHeaderPosition: Int

    init(list: [SkillBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textSkills: String, styleIsBulletedList: Bool, styleIsChips: Bool, styleIsProgressAdded: Bool, styleHeaderPosition: Int) {
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textSkills = textSkills
        self.styleIsBulletedList = styleIsBulletedList
        self.styleIsChips = styleIsChips
        self.styleIsProgressAdded = styleIsProgressAdded
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: SkillsBlockEntity) {
        self.list = []
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textSkills = entity.textSkills
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleIsChips = entity.styleIsChips
        self.styleIsProgressAdded = entity.styleIsProgressAdded
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
}
