//
//  WorkBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class WorkBlockItemEntityWrapper {
    
    var entity: WorkBlockItemEntity?
    
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
    
    init(entity: WorkBlockItemEntity?, desc: String, jobTitle: String, company: String, iconId: Int, location: String, startDate: Date?, endDate: Date?, isStillWorking: Bool, responsibilities: String, remote: Bool, partTime: Bool, isAdded: Bool, position: Int, page: Int) {
        self.entity = entity
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
        self.entity = entity
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
    
    static func getDefault (position: Int) -> WorkBlockItemEntityWrapper {
        return WorkBlockItemEntityWrapper(entity: nil, desc: position == 0 ? NSLocalizedString("dummy_work_one_description", comment: "") : NSLocalizedString("dummy_work_two_description", comment: ""), jobTitle: position == 0 ? NSLocalizedString("dummy_work_one_job", comment: "") : NSLocalizedString("dummy_work_two_job", comment: ""), company: position == 0 ? NSLocalizedString("dummy_work_one_institution", comment: "") : NSLocalizedString("dummy_work_two_institution", comment: ""), iconId: -1, location: position == 0 ? NSLocalizedString("dummy_work_one_location", comment: "") : NSLocalizedString("dummy_work_two_location", comment: ""), startDate: Date(), endDate: Date(), isStillWorking: false, responsibilities: "", remote: false, partTime: false, isAdded: true, position: position, page: 0)
    }
}
