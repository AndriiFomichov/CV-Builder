//
//  SkillBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class SkillBlockItemEntityWrapper {
    
    var entity: SkillBlockItemEntity?
    
    var name: String
    var level: Int
    var iconId: Int
    var category: Int
    var isAdded: Bool
    var position: Int
    
    init(entity: SkillBlockItemEntity?, name: String, level: Int, iconId: Int, category: Int, isAdded: Bool, position: Int) {
        self.entity = entity
        self.name = name
        self.level = level
        self.iconId = iconId
        self.category = category
        self.isAdded = isAdded
        self.position = position
    }
    
    init(entity: SkillBlockItemEntity) {
        self.entity = entity
        self.name = entity.name
        self.level = entity.level
        self.iconId = entity.iconId
        self.category = entity.category
        self.isAdded = entity.isAdded
        self.position = entity.position
    }
    
    static func getDefault (position: Int) -> SkillBlockItemEntityWrapper {
        let name: String
        let category: Int
        switch position {
        case 0:
            name = NSLocalizedString("dummy_skill_one", comment: "")
            category = 0
            break
        case 1:
            name = NSLocalizedString("dummy_skill_two", comment: "")
            category = 0
            break
        case 2:
            name = NSLocalizedString("dummy_skill_three", comment: "")
            category = 0
            break
        case 3:
            name = NSLocalizedString("dummy_skill_four", comment: "")
            category = 0
            break
        case 4:
            name = NSLocalizedString("dummy_skill_five", comment: "")
            category = 0
            break
        case 5:
            name = NSLocalizedString("dummy_skill_six", comment: "")
            category = 0
            break
        default:
            name = NSLocalizedString("dummy_skill_one", comment: "")
            category = 0
            break
        }
        
        return SkillBlockItemEntityWrapper(entity: nil, name: name, level: [2,3,4].randomElement()!, iconId: -1, category: category, isAdded: true, position: position)
    }
}
