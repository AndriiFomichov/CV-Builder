//
//  LanguagesBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class LanguagesBlockEntityWrapper {
    
    var entity: LanguagesBlockEntity?
    
    var list: [LanguageBlockItemEntityWrapper]
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

    init(entity: LanguagesBlockEntity?, list: [LanguageBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textLanguages: String, styleIsBulletedList: Bool, styleIsProgressAdded: Bool, styleIsLevelAdded: Bool, styleIconAdded: Bool, styleHeaderPosition: Int) {
        self.entity = entity
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
        self.entity = entity
        if let list = entity.list {
            var items: [LanguageBlockItemEntityWrapper] = []
            for item in list {
                items.append(LanguageBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
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
    
    static func getDefault (position: Int, isMainBlock: Bool) -> LanguagesBlockEntityWrapper {
        return LanguagesBlockEntityWrapper(entity: nil, list: [ LanguageBlockItemEntityWrapper.getDefault(position: 0), LanguageBlockItemEntityWrapper.getDefault(position: 1) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textLanguages: NSLocalizedString("languages", comment: ""), styleIsBulletedList: true, styleIsProgressAdded: true, styleIsLevelAdded: true, styleIconAdded: true, styleHeaderPosition: 0)
    }
}
