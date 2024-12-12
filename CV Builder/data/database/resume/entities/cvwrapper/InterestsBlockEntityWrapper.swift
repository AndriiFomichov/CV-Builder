//
//  InterestsBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class InterestsBlockEntityWrapper {
    
    var entity: InterestsBlockEntity?
    
    var list: [InterestBlockItemEntityWrapper]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textInterests: String
    
    var styleIsBulletedList: Bool
    var styleIsChips: Bool
    var styleHeaderPosition: Int

    init(entity: InterestsBlockEntity?, list: [InterestBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textInterests: String, styleIsBulletedList: Bool, styleIsChips: Bool, styleHeaderPosition: Int) {
        self.entity = entity
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textInterests = textInterests
        self.styleIsBulletedList = styleIsBulletedList
        self.styleIsChips = styleIsChips
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: InterestsBlockEntity) {
        self.entity = entity
        if let list = entity.list {
            var items: [InterestBlockItemEntityWrapper] = []
            for item in list {
                items.append(InterestBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textInterests = entity.textInterests
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleIsChips = entity.styleIsChips
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> InterestsBlockEntityWrapper {
        return InterestsBlockEntityWrapper(entity: nil, list: [ InterestBlockItemEntityWrapper.getDefault(position: 0), InterestBlockItemEntityWrapper.getDefault(position: 1) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textInterests: NSLocalizedString("interests", comment: ""), styleIsBulletedList: true, styleIsChips: false, styleHeaderPosition: 0)
    }
}
