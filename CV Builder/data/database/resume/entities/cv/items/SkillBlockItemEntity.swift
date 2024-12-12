//
//  SkillBlockItemEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class SkillBlockItemEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var entityId: String
    var name: String
    var level: Int
    var iconId: Int
    var category: Int
    var isAdded: Bool
    var position: Int
    
    init(entityId: String, name: String, level: Int, iconId: Int, category: Int, isAdded: Bool, position: Int) {
        self.entityId = entityId
        self.name = name
        self.level = level
        self.iconId = iconId
        self.category = category
        self.isAdded = isAdded
        self.position = position
    }
    
    init(entity: SkillBlockItemEntity) {
        self.entityId = entity.entityId
        self.name = entity.name
        self.level = entity.level
        self.iconId = entity.iconId
        self.category = entity.category
        self.isAdded = entity.isAdded
        self.position = entity.position
    }
}
