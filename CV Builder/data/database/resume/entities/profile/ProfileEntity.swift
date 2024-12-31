//
//  ProfileEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class ProfileEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var name: String
    var location: String
    var jobTitle: String
    var photoId: Int
    
    var email: String
    var phone: String
    var websiteLink: String
    var websiteQrCodeId: Int
    
    var socialMediasList: [SocialMediaEntity]?
    var skillsList: [SkillEntity]?
    var interestsList: [InterestEntity]?
    var educationsList: [EducationEntity]?
    var worksList: [WorkEntity]?
    var certificatesList: [CertificateEntity]?
    var languagesList: [LanguageEntity]?
    var referencesList: [ReferenceEntity]?
    
    init(name: String, location: String, jobTitle: String, photoId: Int, email: String, phone: String, websiteLink: String, websiteQrCodeId: Int, socialMediasList: [SocialMediaEntity]?, skillsList: [SkillEntity]?, interestsList: [InterestEntity]?, educationsList: [EducationEntity]?, worksList: [WorkEntity]?, certificatesList: [CertificateEntity]?, languagesList: [LanguageEntity]?, referencesList: [ReferenceEntity]?) {
        self.name = name
        self.location = location
        self.jobTitle = jobTitle
        self.photoId = photoId
        self.email = email
        self.phone = phone
        self.websiteLink = websiteLink
        self.websiteQrCodeId = websiteQrCodeId
        self.socialMediasList = socialMediasList
        self.skillsList = skillsList
        self.interestsList = interestsList
        self.educationsList = educationsList
        self.worksList = worksList
        self.certificatesList = certificatesList
        self.languagesList = languagesList
        self.referencesList = referencesList
    }
}
