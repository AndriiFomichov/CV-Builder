//
//  EducationEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class EducationEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
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
    
    init(level: String, institution: String, logoId: Int, fieldOfStudy: String, degree: String, startDate: Date?, endDate: Date?, isStillLearning: Bool, gpa: String, coursework: String, position: Int) {
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
        self.position = position
    }
}
