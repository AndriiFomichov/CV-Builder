//
//  WorkBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class WorkBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [WorkBlockItemEntity]?
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textWorkExperience: String
    
    var styleDateWithHeader: Bool
    var styleDateAfterHeader: Bool
    var styleDateSeparated: Bool
    var styleDateInBrackets: Bool
    var styleMonthDisplayed: Bool
    var styleDotsAdded: Bool
    var styleDescritpionAsBulleted: Bool
    var styleHeaderPosition: Int

    init(list: [WorkBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textWorkExperience: String, styleDateWithHeader: Bool, styleDateAfterHeader: Bool, styleDateSeparated: Bool, styleDateInBrackets: Bool, styleMonthDisplayed: Bool, styleDotsAdded: Bool, styleDescritpionAsBulleted: Bool, styleHeaderPosition: Int) {
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textWorkExperience = textWorkExperience
        self.styleDateWithHeader = styleDateWithHeader
        self.styleDateAfterHeader = styleDateAfterHeader
        self.styleDateSeparated = styleDateSeparated
        self.styleDateInBrackets = styleDateInBrackets
        self.styleMonthDisplayed = styleMonthDisplayed
        self.styleDotsAdded = styleDotsAdded
        self.styleDescritpionAsBulleted = styleDescritpionAsBulleted
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: WorkBlockEntity) {
        self.list = []
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textWorkExperience = entity.textWorkExperience
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
