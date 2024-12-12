//
//  InterestItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class InterestItem {
    
    var entity: InterestEntity
    
    var name: String
    
    var position: Int
    
    init(entity: InterestEntity) {
        self.entity = entity
        self.name = entity.name
        self.position = entity.position
    }
    
    static func getDefault () -> InterestItem {
        return InterestItem(entity: InterestEntity(name: "Hiking", position: 0))
    }
}
