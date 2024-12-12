//
//  ReferencesBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class ReferencesBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [ReferenceBlockItemEntity]?
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int

    var textReferences: String
    
    var styleIsBulletedList: Bool
    var styleHeaderPosition: Int
    
    init(list: [ReferenceBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textReferences: String, styleIsBulletedList: Bool, styleHeaderPosition: Int) {
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
        self.list = []
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textReferences = entity.textReferences
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
}
