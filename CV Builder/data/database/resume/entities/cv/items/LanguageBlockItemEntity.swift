//
//  LanguageBlockItemEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class LanguageBlockItemEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var entityId: String
    var langId: Int
    var name: String
    var level: Int
    var isAdded: Bool
    var position: Int
    var page: Int
    
    init(entityId: String, langId: Int, name: String, level: Int, isAdded: Bool, position: Int, page: Int) {
        self.entityId = entityId
        self.langId = langId
        self.name = name
        self.level = level
        self.isAdded = isAdded
        self.position = position
        self.page = page
    }
    
    init(entity: LanguageBlockItemEntity) {
        self.entityId = entity.entityId
        self.langId = entity.langId
        self.name = entity.name
        self.level = entity.level
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.page = entity.page
    }
}
