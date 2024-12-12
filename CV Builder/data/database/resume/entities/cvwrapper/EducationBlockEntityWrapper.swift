//
//  EducationBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class EducationBlockEntityWrapper {
    
    var entity: EducationBlockEntity?
    
    var list: [EducationBlockItemEntityWrapper]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textEducation: String
    
    var styleDateWithHeader: Bool
    var styleDateAfterHeader: Bool
    var styleDateSeparated: Bool
    var styleDateInBrackets: Bool
    var styleMonthDisplayed: Bool
    var styleDotsAdded: Bool
    var styleDescritpionAsBulleted: Bool
    var styleHeaderPosition: Int

    init(entity: EducationBlockEntity?, list: [EducationBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textEducation: String, styleDateWithHeader: Bool, styleDateAfterHeader: Bool, styleDateSeparated: Bool, styleDateInBrackets: Bool, styleMonthDisplayed: Bool, styleDotsAdded: Bool, styleDescritpionAsBulleted: Bool, styleHeaderPosition: Int) {
        self.entity = entity
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textEducation = textEducation
        self.styleDateWithHeader = styleDateWithHeader
        self.styleDateAfterHeader = styleDateAfterHeader
        self.styleDateSeparated = styleDateSeparated
        self.styleDateInBrackets = styleDateInBrackets
        self.styleMonthDisplayed = styleMonthDisplayed
        self.styleDotsAdded = styleDotsAdded
        self.styleDescritpionAsBulleted = styleDescritpionAsBulleted
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: EducationBlockEntity) {
        self.entity = entity
        if let list = entity.list {
            var items: [EducationBlockItemEntityWrapper] = []
            for item in list {
                items.append(EducationBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textEducation = entity.textEducation
        self.styleDateWithHeader = entity.styleDateWithHeader
        self.styleDateAfterHeader = entity.styleDateAfterHeader
        self.styleDateSeparated = entity.styleDateSeparated
        self.styleDateInBrackets = entity.styleDateInBrackets
        self.styleMonthDisplayed = entity.styleMonthDisplayed
        self.styleDotsAdded = entity.styleDotsAdded
        self.styleDescritpionAsBulleted = entity.styleDescritpionAsBulleted
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> EducationBlockEntityWrapper {
        return EducationBlockEntityWrapper(entity: nil, list: [ EducationBlockItemEntityWrapper.getDefault(position: 0), EducationBlockItemEntityWrapper.getDefault(position: 1), EducationBlockItemEntityWrapper.getDefault(position: 2), EducationBlockItemEntityWrapper.getDefault(position: 3) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textEducation: NSLocalizedString("education", comment: ""), styleDateWithHeader: false, styleDateAfterHeader: false, styleDateSeparated: true, styleDateInBrackets: true, styleMonthDisplayed: false, styleDotsAdded: true, styleDescritpionAsBulleted: true, styleHeaderPosition: 0)
    }
}
