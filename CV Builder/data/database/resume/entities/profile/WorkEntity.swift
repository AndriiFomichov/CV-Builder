//
//  WorkEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class WorkEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
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
    
    init(jobTitle: String, company: String, iconId: Int, location: String, startDate: Date?, endDate: Date?, isStillWorking: Bool, responsibilities: String, remote: Bool, partTime: Bool, position: Int) {
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
        self.position = position
    }
}
