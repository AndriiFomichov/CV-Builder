//
//  ReferencesBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class ReferencesBlockEntityWrapper {
    
    var entity: ReferencesBlockEntity?
    
    var list: [ReferenceBlockItemEntityWrapper]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int

    var textReferences: String
    
    var styleIsBulletedList: Bool
    var styleHeaderPosition: Int
    
    init(entity: ReferencesBlockEntity?, list: [ReferenceBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textReferences: String, styleIsBulletedList: Bool, styleHeaderPosition: Int) {
        self.entity = entity
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textReferences = textReferences
        self.styleIsBulletedList = styleIsBulletedList
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: ReferencesBlockEntity) {
        self.entity = entity
        if let list = entity.list {
            var items: [ReferenceBlockItemEntityWrapper] = []
            for item in list {
                items.append(ReferenceBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textReferences = entity.textReferences
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> ReferencesBlockEntityWrapper {
        return ReferencesBlockEntityWrapper(entity: nil, list: [ ReferenceBlockItemEntityWrapper.getDefault(position: 0), ReferenceBlockItemEntityWrapper.getDefault(position: 1) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textReferences: NSLocalizedString("references", comment: ""), styleIsBulletedList: true, styleHeaderPosition: 0)
    }
}
