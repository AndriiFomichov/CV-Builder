//
//  EducationBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class EducationBlockItemEntityWrapper {
    
    var entity: EducationBlockItemEntity?
    
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
    
    init(entity: EducationBlockItemEntity?, desc: String, level: String, institution: String, logoId: Int, fieldOfStudy: String, degree: String, startDate: Date?, endDate: Date?, isStillLearning: Bool, gpa: String, coursework: String, isAdded: Bool, position: Int, page: Int) {
        self.entity = entity
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
        self.entity = entity
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
    
    static func getDefault (position: Int) -> EducationBlockItemEntityWrapper {
        return EducationBlockItemEntityWrapper(entity: nil, desc: position == 0 ? NSLocalizedString("dummy_education_one_description", comment: "") : NSLocalizedString("dummy_education_two_description", comment: ""), level: position == 0 ? NSLocalizedString("dummy_education_one_level", comment: "") : NSLocalizedString("dummy_education_two_level", comment: ""), institution: position == 0 ? NSLocalizedString("dummy_education_one_institution", comment: "") : NSLocalizedString("dummy_education_two_institution", comment: ""), logoId: -1, fieldOfStudy: position == 0 ? NSLocalizedString("dummy_education_one_field", comment: "") : NSLocalizedString("dummy_education_two_field", comment: ""), degree: position == 0 ? NSLocalizedString("dummy_education_one_degree", comment: "") : NSLocalizedString("dummy_education_two_degree", comment: ""), startDate: Date(), endDate: Date(), isStillLearning: false, gpa: "3.5", coursework: "", isAdded: true, position: position, page: 0)
    }
}
