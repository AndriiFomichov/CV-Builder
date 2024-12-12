//
//  InterestBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class InterestBlockItemEntityWrapper {
    
    var entity: InterestBlockItemEntity?
    
    var name: String
    var isAdded: Bool
    var position: Int
    
    init(entity: InterestBlockItemEntity?, name: String, isAdded: Bool, position: Int) {
        self.entity = entity
        self.name = name
        self.isAdded = isAdded
        self.position = position
    }
    
    init(entity: InterestBlockItemEntity) {
        self.entity = entity
        self.name = entity.name
        self.isAdded = entity.isAdded
        self.position = entity.position
    }
    
    static func getDefault (position: Int) -> InterestBlockItemEntityWrapper {
        let name: String
        switch position {
        case 0:
            name = NSLocalizedString("dummy_interest_one", comment: "")
            break
        case 1:
            name = NSLocalizedString("dummy_interest_two", comment: "")
            break
        case 2:
            name = NSLocalizedString("dummy_interest_three", comment: "")
            break
        default:
            name = NSLocalizedString("dummy_interest_one", comment: "")
            break
        }
        return InterestBlockItemEntityWrapper(entity: nil, name: name, isAdded: true, position: position)
    }
}
