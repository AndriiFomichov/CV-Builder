//
//  SkillsItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation
import UIKit

class SkillsItem {
    
    var entity: SkillEntity
    
    var name: String
    var level: Int
    var iconId: Int
    var category: Int
    
    var position: Int
    
    var iconPreview: UIImage?
    
    init(entity: SkillEntity, iconPreview: UIImage?) {
        self.entity = entity
        self.name = entity.name
        self.level = entity.level
        self.iconId = entity.iconId
        self.category = entity.category
        self.position = entity.position
        self.iconPreview = iconPreview
    }
    
    static func getDefault () -> SkillsItem {
        return SkillsItem(entity: SkillEntity(name: "Skill", level: -1, iconId: -1, category: 1, position: 0), iconPreview: nil)
    }
}
