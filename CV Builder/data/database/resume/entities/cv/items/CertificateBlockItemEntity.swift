//
//  CertificateBlockItemEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class CertificateBlockItemEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var entityId: String
    var name: String
    var isAdded: Bool
    var position: Int
    
    init(entityId: String, name: String, isAdded: Bool, position: Int) {
        self.entityId = entityId
        self.name = name
        self.isAdded = isAdded
        self.position = position
    }
    
    init(entity: CertificateBlockItemEntity) {
        self.entityId = entity.entityId
        self.name = entity.name
        self.isAdded = entity.isAdded
        self.position = entity.position
    }
}
