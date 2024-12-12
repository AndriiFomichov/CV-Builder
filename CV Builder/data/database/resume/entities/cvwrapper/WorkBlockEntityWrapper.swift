//
//  WorkBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class WorkBlockEntityWrapper {
    
    var entity: WorkBlockEntity?
    
    var list: [WorkBlockItemEntityWrapper]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var experience: String
    var workExperience: String
    
    var styleDateWithHeader: Bool
    var styleDateAfterHeader: Bool
    var styleDateSeparated: Bool
    var styleDateInBrackets: Bool
    var styleMonthDisplayed: Bool
    var styleDotsAdded: Bool
    var styleDescritpionAsBulleted: Bool
    var styleHeaderPosition: Int

    init(entity: WorkBlockEntity?, list: [WorkBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, experience: String, workExperience: String, styleDateWithHeader: Bool, styleDateAfterHeader: Bool, styleDateSeparated: Bool, styleDateInBrackets: Bool, styleMonthDisplayed: Bool, styleDotsAdded: Bool, styleDescritpionAsBulleted: Bool, styleHeaderPosition: Int) {
        self.entity = entity
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.experience = experience
        self.workExperience = workExperience
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
        self.entity = entity
        if let list = entity.list {
            var items: [WorkBlockItemEntityWrapper] = []
            for item in list {
                items.append(WorkBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.experience = entity.experience
        self.workExperience = entity.workExperience
        self.styleDateWithHeader = entity.styleDateWithHeader
        self.styleDateAfterHeader = entity.styleDateAfterHeader
        self.styleDateSeparated = entity.styleDateSeparated
        self.styleDateInBrackets = entity.styleDateInBrackets
        self.styleMonthDisplayed = entity.styleMonthDisplayed
        self.styleDotsAdded = entity.styleDotsAdded
        self.styleDescritpionAsBulleted = entity.styleDescritpionAsBulleted
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> WorkBlockEntityWrapper {
        return WorkBlockEntityWrapper(entity: nil, list: [ WorkBlockItemEntityWrapper.getDefault(position: 0), WorkBlockItemEntityWrapper.getDefault(position: 1), WorkBlockItemEntityWrapper.getDefault(position: 2), WorkBlockItemEntityWrapper.getDefault(position: 3) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, experience: NSLocalizedString("experience", comment: ""), workExperience: NSLocalizedString("work_experience", comment: ""), styleDateWithHeader: true, styleDateAfterHeader: true, styleDateSeparated: false, styleDateInBrackets: false, styleMonthDisplayed: true, styleDotsAdded: true, styleDescritpionAsBulleted: true, styleHeaderPosition: 0)
    }
}
