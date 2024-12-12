//
//  EducationBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class EducationBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [EducationBlockItemEntity]?
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

    init(list: [EducationBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textEducation: String, styleDateWithHeader: Bool, styleDateAfterHeader: Bool, styleDateSeparated: Bool, styleDateInBrackets: Bool, styleMonthDisplayed: Bool, styleDotsAdded: Bool, styleDescritpionAsBulleted: Bool, styleHeaderPosition: Int) {
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
        self.list = []
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
}
