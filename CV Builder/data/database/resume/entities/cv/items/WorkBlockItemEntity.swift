//
//  WorkBlockItemEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class WorkBlockItemEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var entityId: String
    var desc: String
    var jobTitle: String
    var company: String
    var iconId: Int
    var location: String
    var startDate: Date?
    var endDate: Date?
    var isStillWorking: Bool
    var responsibilities: String
    var remote: Bool
    var partTime: Bool
    var isAdded: Bool
    var position: Int
    var page: Int
    
    init(entityId: String, desc: String, jobTitle: String, company: String, iconId: Int, location: String, startDate: Date?, endDate: Date?, isStillWorking: Bool, responsibilities: String, remote: Bool, partTime: Bool, isAdded: Bool, position: Int, page: Int) {
        self.entityId = entityId
        self.desc = desc
        self.jobTitle = jobTitle
        self.company = company
        self.iconId = iconId
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.isStillWorking = isStillWorking
        self.responsibilities = responsibilities
        self.remote = remote
        self.partTime = partTime
        self.isAdded = isAdded
        self.position = position
        self.page = page
    }
    
    init(entity: WorkBlockItemEntity) {
        self.entityId = entity.entityId
        self.desc = entity.desc
        self.jobTitle = entity.jobTitle
        self.company = entity.company
        self.iconId = entity.iconId
        self.location = entity.location
        self.startDate = entity.startDate
        self.endDate = entity.endDate
        self.isStillWorking = entity.isStillWorking
        self.responsibilities = entity.responsibilities
        self.remote = entity.remote
        self.partTime = entity.partTime
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.page = entity.page
    }
}
