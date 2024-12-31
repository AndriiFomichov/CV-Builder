//
//  LanguagesBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class LanguagesBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [LanguageBlockItemEntity]?
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textLanguages: String
    
    var styleIsBulletedList: Bool
    var styleIsProgressAdded: Bool
    var styleIsLevelAdded: Bool
    var styleIconAdded: Bool
    var styleHeaderPosition: Int

    init(list: [LanguageBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textLanguages: String, styleIsBulletedList: Bool, styleIsProgressAdded: Bool, styleIsLevelAdded: Bool, styleIconAdded: Bool, styleHeaderPosition: Int) {
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textLanguages = textLanguages
        self.styleIsBulletedList = styleIsBulletedList
        self.styleIsProgressAdded = styleIsProgressAdded
        self.styleIsLevelAdded = styleIsLevelAdded
        self.styleIconAdded = styleIconAdded
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: LanguagesBlockEntity) {
        self.list = []
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textLanguages = entity.textLanguages
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleIsProgressAdded = entity.styleIsProgressAdded
        self.styleIsLevelAdded = entity.styleIsLevelAdded
        self.styleIconAdded = entity.styleIconAdded
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
}
