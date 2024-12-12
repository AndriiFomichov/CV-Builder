//
//  SkillEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class SkillEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var name: String
    var level: Int
    var iconId: Int
    var category: Int
    
    var position: Int
    
    init(name: String, level: Int, iconId: Int, category: Int, position: Int) {
        self.name = name
        self.level = level
        self.iconId = iconId
        self.category = category
        self.position = position
    }
}
