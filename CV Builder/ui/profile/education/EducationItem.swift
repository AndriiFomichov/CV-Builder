//
//  EducationItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import Foundation

class EducationItem {
    
    var entity: EducationEntity
    
    var level: String
    var institution: String
    var logoId: Int
    var fieldOfStudy: String
    var degree: String
    var startDate: Date?
    var endDate: Date?
    var isStillLearning: Bool
    var gpa: String
    var coursework: String
    
    var position: Int
    
    init(entity: EducationEntity) {
        self.entity = entity
        self.level = entity.level
        self.institution = entity.institution
        self.logoId = entity.logoId
        self.fieldOfStudy = entity.fieldOfStudy
        self.degree = entity.degree
        self.startDate = entity.startDate
        self.endDate = entity.endDate
        self.isStillLearning = entity.isStillLearning
        self.gpa = entity.gpa
        self.coursework = entity.coursework
        self.position = entity.position
    }
    
    static func getDefault () -> EducationItem {
        return EducationItem(entity: EducationEntity(level: "Bachelor", institution: "Harvard", logoId: -1, fieldOfStudy: "Economics", degree: "Bachelor", startDate: Date(), endDate: nil, isStillLearning: true, gpa: "3.8", coursework: "", position: 0))
    }
}
