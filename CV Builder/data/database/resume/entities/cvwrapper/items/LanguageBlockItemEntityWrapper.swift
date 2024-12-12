//
//  LanguageBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class LanguageBlockItemEntityWrapper {
    
    var entity: LanguageBlockItemEntity?
    
    var langId: Int
    var name: String
    var level: Int
    var isAdded: Bool
    var position: Int
    var page: Int
    
    init(entity: LanguageBlockItemEntity?, langId: Int, name: String, level: Int, isAdded: Bool, position: Int, page: Int) {
        self.entity = entity
        self.langId = langId
        self.name = name
        self.level = level
        self.isAdded = isAdded
        self.position = position
        self.page = page
    }
    
    init(entity: LanguageBlockItemEntity) {
        self.entity = entity
        self.langId = entity.langId
        self.name = entity.name
        self.level = entity.level
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.page = entity.page
    }
    
    static func getDefault (position: Int) -> LanguageBlockItemEntityWrapper {
        return LanguageBlockItemEntityWrapper(entity: nil, langId: position == 0 ? 4 : 5, name: position == 0 ? NSLocalizedString("dummy_language_one", comment: "") : NSLocalizedString("dummy_language_two", comment: ""), level: [3,4,5].randomElement()!, isAdded: true, position: position, page: 0)
    }
}
