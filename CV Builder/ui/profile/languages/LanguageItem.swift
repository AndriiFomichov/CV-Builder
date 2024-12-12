//
//  LanguageItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class LanguageItem {
    
    var entity: LanguageEntity
    
    var langId: Int
    var name: String
    var level: Int
    
    var position: Int
    
    init(entity: LanguageEntity) {
        self.entity = entity
        self.langId = entity.langId
        self.name = entity.name
        self.level = entity.level
        self.position = entity.position
    }
    
    static func getDefault () -> LanguageItem {
        return LanguageItem(entity: LanguageEntity(langId: 0, name: "Catalan", level: 0, position: 0))
    }
}
