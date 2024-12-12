//
//  SkillsBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class SkillsBlockEntityWrapper {
    
    var entity: SkillsBlockEntity?
    
    var list: [SkillBlockItemEntityWrapper]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textSkills: String
    
    var styleIsBulletedList: Bool
    var styleIsChips: Bool
    var styleIsProgressAdded: Bool
    var styleHeaderPosition: Int

    init(entity: SkillsBlockEntity?, list: [SkillBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textSkills: String, styleIsBulletedList: Bool, styleIsChips: Bool, styleIsProgressAdded: Bool, styleHeaderPosition: Int) {
        self.entity = entity
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
        self.entity = entity
        if let list = entity.list {
            var items: [SkillBlockItemEntityWrapper] = []
            for item in list {
                items.append(SkillBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
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
    
    static func getDefault (position: Int, isMainBlock: Bool) -> SkillsBlockEntityWrapper {
        return SkillsBlockEntityWrapper(entity: nil, list: [ SkillBlockItemEntityWrapper.getDefault(position: 0), SkillBlockItemEntityWrapper.getDefault(position: 1), SkillBlockItemEntityWrapper.getDefault(position: 2), SkillBlockItemEntityWrapper.getDefault(position: 3) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textSkills: NSLocalizedString("skills", comment: ""), styleIsBulletedList: true, styleIsChips: true, styleIsProgressAdded: true, styleHeaderPosition: 0)
    }
}
