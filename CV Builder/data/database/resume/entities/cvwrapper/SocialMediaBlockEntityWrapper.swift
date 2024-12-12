//
//  SocialMediaBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class SocialMediaBlockEntityWrapper {
    
    var entity: SocialMediaBlockEntity?
    
    var list: [SocialMediaBlockItemEntityWrapper]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var styleIconAdded: Bool
    var styleHeaderPosition: Int

    init(entity: SocialMediaBlockEntity?, list: [SocialMediaBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, styleIconAdded: Bool, styleHeaderPosition: Int) {
        self.entity = entity
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.styleIconAdded = styleIconAdded
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: SocialMediaBlockEntity) {
        self.entity = entity
        if let list = entity.list {
            var items: [SocialMediaBlockItemEntityWrapper] = []
            for item in list {
                items.append(SocialMediaBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.styleIconAdded = entity.styleIconAdded
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> SocialMediaBlockEntityWrapper {
        return SocialMediaBlockEntityWrapper(entity: nil, list: [ SocialMediaBlockItemEntityWrapper.getDefault(position: 0), SocialMediaBlockItemEntityWrapper.getDefault(position: 1) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, styleIconAdded: true, styleHeaderPosition: 0)
    }
}
