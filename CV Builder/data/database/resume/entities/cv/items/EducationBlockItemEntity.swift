//
//  EducationBlockItemEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class EducationBlockItemEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var entityId: String
    var desc: String
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
    var isAdded: Bool
    var position: Int
    var page: Int
    
    init(entityId: String, desc: String, level: String, institution: String, logoId: Int, fieldOfStudy: String, degree: String, startDate: Date?, endDate: Date?, isStillLearning: Bool, gpa: String, coursework: String, isAdded: Bool, position: Int, page: Int) {
        self.entityId = entityId
        self.desc = desc
        self.level = level
        self.institution = institution
        self.logoId = logoId
        self.fieldOfStudy = fieldOfStudy
        self.degree = degree
        self.startDate = startDate
        self.endDate = endDate
        self.isStillLearning = isStillLearning
        self.gpa = gpa
        self.coursework = coursework
        self.isAdded = isAdded
        self.position = position
        self.page = page
    }
    
    init(entity: EducationBlockItemEntity) {
        self.entityId = entity.entityId
        self.desc = entity.desc
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
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.page = entity.page
    }
}
