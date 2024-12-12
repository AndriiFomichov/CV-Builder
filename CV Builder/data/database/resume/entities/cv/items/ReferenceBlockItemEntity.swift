//
//  ReferenceBlockItemEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class ReferenceBlockItemEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var entityId: String
    var referralName: String
    var company: String
    var email: String
    var phone: String
    var isAdded: Bool
    var position: Int
    
    init(entityId: String, referralName: String, company: String, email: String, phone: String, isAdded: Bool, position: Int) {
        self.entityId = entityId
        self.referralName = referralName
        self.company = company
        self.email = email
        self.phone = phone
        self.isAdded = isAdded
        self.position = position
    }
    
    init(entity: ReferenceBlockItemEntity) {
        self.entityId = entity.entityId
        self.referralName = entity.referralName
        self.company = entity.company
        self.email = entity.email
        self.phone = entity.phone
        self.isAdded = entity.isAdded
        self.position = entity.position
    }
}
