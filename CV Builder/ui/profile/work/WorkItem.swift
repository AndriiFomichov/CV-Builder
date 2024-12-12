//
//  WorkItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import Foundation

class WorkItem {
    
    var entity: WorkEntity
    
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
    
    var position: Int
    
    init(entity: WorkEntity) {
        self.entity = entity
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
        self.position = entity.position
    }
    
    static func getDefault () -> WorkItem {
        return WorkItem(entity: WorkEntity(jobTitle: "Job", company: "Company", iconId: -1, location: "Kyiv", startDate: nil, endDate: nil, isStillWorking: true, responsibilities: "", remote: false, partTime: false, position: 0))
    }
}
