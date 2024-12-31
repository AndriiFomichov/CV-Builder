//
//  ProfileManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import Foundation
import UIKit

class ProfileManager {
    
//    func saveContext () {
//        DispatchQueue.main.async {
//            DatabaseBox.saveContext()
//        }
//    }
    
    func createProfile () -> ProfileEntity {
        let profile = ProfileEntity(name: "", location: "", jobTitle: "", photoId: -1, email: "", phone: "", websiteLink: "", websiteQrCodeId: -1, socialMediasList: [], skillsList: [], interestsList: [], educationsList: [], worksList: [], certificatesList: [], languagesList: [], referencesList: [])
        
        DatabaseBox.saveEntity(item: profile)
        
        return profile
    }
    
    func savePhoto (image: Data?, isBackgroundRemoved: Bool = false, maxSize: CGFloat = 750) async -> Int {
        if let image, var resizedImage = UIImage(data: image) {
            
            print("Init size. Width: " + String(Int(resizedImage.size.width)) + " height: " + String(Int(resizedImage.size.height)))
            
            if resizedImage.size.height > maxSize || resizedImage.size.width > maxSize {
                resizedImage = await resizedImage.resizeAsync(height: maxSize)
            }
            
            var id = 0
            let list = getImagesWithoutPreview()
            if list.count > 0 {
                id = list[list.count-1].realId + 1
            }
            
            print("Saving size. Width: " + String(Int(resizedImage.size.width)) + " height: " + String(Int(resizedImage.size.height)))
            
            let finalData = resizedImage.pngData()
            
            if let finalData {
                let item = ImageEntity(realId: id, width: Int(resizedImage.size.width), height: Int(resizedImage.size.height), isBackgroundRemoved: isBackgroundRemoved, category: 0, image: finalData)
                DatabaseBox.saveEntity(item: item)
                print("Saved")
            } else {
                id = -1
            }
            return id
        }
        return -1
    }
    
    func saveQRCode (image: Data?, link: String, maxSize: CGFloat = 750) async -> Int {
        if let image, var resizedImage = UIImage(data: image) {
            
            print("Init size. Width: " + String(Int(resizedImage.size.width)) + " height: " + String(Int(resizedImage.size.height)))
            
            if resizedImage.size.height > maxSize || resizedImage.size.width > maxSize {
                resizedImage = await resizedImage.resizeAsync(height: maxSize)
            }
            
            var id = 0
            let list = getQRCodesWithoutPreview()
            if list.count > 0 {
                id = list[list.count-1].realId + 1
            }
            
            print("Saving size. Width: " + String(Int(resizedImage.size.width)) + " height: " + String(Int(resizedImage.size.height)))
            
            let finalData = resizedImage.pngData()
            
            if let finalData {
                let item = QRCodeEntity(realId: id, width: Int(resizedImage.size.width), height: Int(resizedImage.size.height), link: link, image: finalData)
                DatabaseBox.saveEntity(item: item)
                print("Saved")
            } else {
                id = -1
            }
            return id
        }
        return -1
    }
    
    func saveProfileEducation (profile: ProfileEntity, level: String = "", institution: String = "", logoId: Int = -1, field: String = "", start: Date? = nil, end: Date? = nil, degree: String = "", isStillLearning: Bool = false, gpa: String = "", coursework: String = "") {
        let finalEducation = EducationEntity(level: level, institution: institution, logoId: logoId, fieldOfStudy: field, degree: degree, startDate: start, endDate: end, isStillLearning: isStillLearning, gpa: gpa, coursework: coursework, position: 0)
        DatabaseBox.saveEntity(item: finalEducation)
        
        if var list = profile.educationsList {
            finalEducation.position = list.count
            
            list.append(finalEducation)
            profile.educationsList = list
        }
        
        DatabaseBox.saveContext()
    }
    
    func saveWorkExperience (profile: ProfileEntity, jobTitle: String = "", company: String = "", iconId: Int = -1, location: String = "", start: Date? = nil, end: Date? = nil, isStillWorking: Bool = false, responsibilities: String = "", remote: Bool = false, partTime: Bool = false) {
        
        let finalWork = WorkEntity(jobTitle: jobTitle, company: company, iconId: iconId, location: location, startDate: start, endDate: end, isStillWorking: isStillWorking, responsibilities: responsibilities, remote: remote, partTime: partTime, position: 0)
        DatabaseBox.saveEntity(item: finalWork)
        
        if var list = profile.worksList {
            finalWork.position = list.count
            
            list.append(finalWork)
            profile.worksList = list
        }
        
        DatabaseBox.saveContext()
    }
    
    func saveSkill (profile: ProfileEntity, name: String = "", level: Int = -1, iconId: Int = -1, category: Int = 0) -> SkillEntity {
        let finalSkill = SkillEntity(name: name, level: level, iconId: iconId, category: category, position: 0)
        DatabaseBox.saveEntity(item: finalSkill)
        
        if var list = profile.skillsList {
            finalSkill.position = list.count
            
            list.append(finalSkill)
            profile.skillsList = list
        }
        
        DatabaseBox.saveContext()
        return finalSkill
    }
    
    func saveLanguage (profile: ProfileEntity, langId: Int = -1, name: String = "", level: Int = -1) {
        let finalLanguage = LanguageEntity(langId: langId, name: name, level: level, position: 0)
        DatabaseBox.saveEntity(item: finalLanguage)
        
        if var list = profile.languagesList {
            finalLanguage.position = list.count
            
            list.append(finalLanguage)
            profile.languagesList = list
        }
        
        DatabaseBox.saveContext()
    }
    
    func saveInterest (profile: ProfileEntity, name: String = "") {
        let finalInterest = InterestEntity(name: name, position: 0)
        DatabaseBox.saveEntity(item: finalInterest)
        
        if var list = profile.interestsList {
            finalInterest.position = list.count
            
            list.append(finalInterest)
            profile.interestsList = list
        }
        
        DatabaseBox.saveContext()
    }
    
    func saveSocialMedia (profile: ProfileEntity, link: String = "", media: Int = -1, qrCodeId: Int = -1) {
        let finalMedia = SocialMediaEntity(link: link, media: media, qrCodeId: qrCodeId, position: 0)
        DatabaseBox.saveEntity(item: finalMedia)
        
        if var list = profile.socialMediasList {
            finalMedia.position = list.count
            
            list.append(finalMedia)
            profile.socialMediasList = list
        }
        
        DatabaseBox.saveContext()
    }
    
    func saveCertificate (profile: ProfileEntity, name: String = "") -> CertificateEntity {
        let finalCertificate = CertificateEntity(name: name, position: 0)
        DatabaseBox.saveEntity(item: finalCertificate)
        
        if var list = profile.certificatesList {
            finalCertificate.position = list.count
            
            list.append(finalCertificate)
            profile.certificatesList = list
        }
        
        DatabaseBox.saveContext()
        return finalCertificate
    }
    
    func saveReference (profile: ProfileEntity, referralName: String = "", company: String = "", email: String = "", phone: String = "") {
        let finalReference = ReferenceEntity(referralName: referralName, company: company, email: email, phone: phone, position: 0)
        DatabaseBox.saveEntity(item: finalReference)
        
        if var list = profile.referencesList {
            finalReference.position = list.count
            
            list.append(finalReference)
            profile.referencesList = list
        }
        
        DatabaseBox.saveContext()
    }
    
    
    
    // update
    
    func updateGeneralDate (profile: ProfileEntity, name: String = "", location: String = "", jobTitle: String = "") {
        profile.name = name
        profile.location = location
        profile.jobTitle = jobTitle
        DatabaseBox.saveContext()
    }
    
    func updateEducation (education: EducationEntity, level: String = "", institution: String = "", logoId: Int = -1, field: String = "", start: Date? = nil, end: Date? = nil, degree: String = "", isStillLearning: Bool = false, gpa: String = "", coursework: String = "", position: Int = 0) {
        education.level = level
        education.institution = institution
        education.logoId = logoId
        education.fieldOfStudy = field
        education.startDate = start
        education.endDate = end
        education.degree = degree
        education.isStillLearning = isStillLearning
        education.gpa = gpa
        education.coursework = coursework
        education.position = position
        DatabaseBox.saveContext()
    }
    
    
    func updateWork (work: WorkEntity, jobTitle: String = "", company: String = "", iconId: Int = -1, location: String = "", start: Date? = nil, end: Date? = nil, isStillWorking: Bool = false, responsibilities: String = "", remote: Bool = false, partTime: Bool = false, position: Int = 0) {
        work.jobTitle = jobTitle
        work.company = company
        work.iconId = iconId
        work.location = location
        work.startDate = start
        work.endDate = end
        work.isStillWorking = isStillWorking
        work.responsibilities = responsibilities
        work.remote = remote
        work.partTime = partTime
        work.position = position
        DatabaseBox.saveContext()
    }
    
    func updateSkill (skill: SkillEntity, name: String = "", level: Int = -1, iconId: Int = -1, category: Int = 0, position: Int = 0) {
        skill.name = name
        skill.level = level
        skill.iconId = iconId
        skill.category = category
        skill.position = position
        DatabaseBox.saveContext()
    }
    
    func updateLanguage (language: LanguageEntity, langId: Int = -1, name: String = "", level: Int = -1, position: Int = 0) {
        language.langId = langId
        language.name = name
        language.level = level
        language.position = position
        DatabaseBox.saveContext()
    }
    
    func updateSocialMedia (socialMedia: SocialMediaEntity, link: String = "", media: Int = -1, qrCodeId: Int = -1, position: Int = 0) {
        socialMedia.link = link
        socialMedia.media = media
        socialMedia.qrCodeId = qrCodeId
        socialMedia.position = position
        DatabaseBox.saveContext()
    }
    
    func updateCertificate (certificate: CertificateEntity, name: String = "", position: Int = 0) {
        certificate.name = name
        certificate.position = position
        DatabaseBox.saveContext()
    }
    
    func updateReference (reference: ReferenceEntity, referralName: String = "", company: String = "", email: String = "", phone: String = "", position: Int = 0) {
        reference.referralName = referralName
        reference.company = company
        reference.email = email
        reference.phone = phone
        reference.position = position
        DatabaseBox.saveContext()
    }
    
    
    
    // delete
    
    func deleteEducation (profile: ProfileEntity, education: EducationEntity) {
        let position = ProfileEntitiesGetter.getEducationPosition(education: education, profile: profile)
        if position != -1, var list = profile.educationsList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.educationsList = list
            
            DatabaseBox.deleteEntity(item: education)
        }
    }
    
    func deleteWork (profile: ProfileEntity, work: WorkEntity) {
        let position = ProfileEntitiesGetter.getWorkPosition(work: work, profile: profile)
        if position != -1, var list = profile.worksList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.worksList = list
            
            deleteImage(id: work.iconId)
            
            DatabaseBox.deleteEntity(item: work)
        }
    }
    
    func deleteSkill (profile: ProfileEntity, skill: SkillEntity) {
        let position = ProfileEntitiesGetter.getSkillPosition(skill: skill, profile: profile)
        if position != -1, var list = profile.skillsList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.skillsList = list
            
            deleteImage(id: skill.iconId)
            
            DatabaseBox.deleteEntity(item: skill)
        }
    }
    
    func deleteLanguage (profile: ProfileEntity, language: LanguageEntity) {
        let position = ProfileEntitiesGetter.getLanguagePosition(language: language, profile: profile)
        if position != -1, var list = profile.languagesList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.languagesList = list
            
            DatabaseBox.deleteEntity(item: language)
        }
    }
    
    func deleteInterest (profile: ProfileEntity, interest: InterestEntity) {
        let position = ProfileEntitiesGetter.getInterestPosition(interest: interest, profile: profile)
        if position != -1, var list = profile.interestsList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.interestsList = list
            
            DatabaseBox.saveContext()
        }
    }
    
    func deleteSocialMedia (profile: ProfileEntity, socialMedia: SocialMediaEntity) {
        let position = ProfileEntitiesGetter.getSocialMediaPosition(media: socialMedia, profile: profile)
        if position != -1, var list = profile.socialMediasList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.socialMediasList = list
            
            deleteQrCode(id: socialMedia.qrCodeId)
            
            DatabaseBox.deleteEntity(item: socialMedia)
        }
    }
    
    func deleteCertificate (profile: ProfileEntity, certificate: CertificateEntity) {
        let position = ProfileEntitiesGetter.getCertificatePosition(certificate: certificate, profile: profile)
        if position != -1, var list = profile.certificatesList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.certificatesList = list
            
            DatabaseBox.deleteEntity(item: certificate)
        }
    }
    
    func deleteReference (profile: ProfileEntity, reference: ReferenceEntity) {
        let position = ProfileEntitiesGetter.getReferencePosition(reference: reference, profile: profile)
        if position != -1, var list = profile.referencesList, position < list.count {
            list.remove(at: position)
            
            list = list.sorted(by: { $0.position < $1.position })
            for i in 0..<list.count {
                let item = list[i]
                item.position = i
                list[i] = item
            }
            
            profile.referencesList = list
            
            DatabaseBox.deleteEntity(item: reference)
        }
    }
    
    func deleteImage (id: Int) {
        if id != -1, let image = DatabaseBox.getImage(id: id) {
            DatabaseBox.deleteEntity(item: image)
        }
    }
    
    func deleteQrCode (id: Int) {
        if id != -1, let image = DatabaseBox.getQRCode(id: id) {
            DatabaseBox.deleteEntity(item: image)
        }
    }
    
    
    
    // Get
    func getImagesWithoutPreview(limit: Int = -1) -> [ImageEntity] {
        return DatabaseBox.getImagesWithoutPreview(limit: limit)
    }
    
    func getQRCodesWithoutPreview(limit: Int = -1) -> [QRCodeEntity] {
        return DatabaseBox.getQRCodesWithoutPreview(limit: limit)
    }
    
    func getProfile() -> ProfileEntity? {
        return DatabaseBox.getProfile()
    }
    
    func getIfProfileMainFilled (profile: ProfileEntity) -> Bool {
        let generalFilled = !profile.name.isEmpty && !profile.jobTitle.isEmpty
        
        var educationFilled = true
        if let educationsList = profile.educationsList {
            educationFilled = educationsList.count > 0
        } else {
            educationFilled = false
        }
        
        var workFilled = true
        if let worksList = profile.worksList {
            workFilled = worksList.count > 0
        } else {
            workFilled = false
        }
        
        return generalFilled && educationFilled && workFilled
    }
    
    func getProfileFillPercent (profile: ProfileEntity) -> CGFloat {
        let generalStatus = getGeneralInfoCategoryStatus(profile: profile)
        let contactStatus = getContactCategoryStatus(profile: profile)
        let socialStatus = getSocialCategoryStatus(profile: profile)
        let educationStatus = getEducationCategoryStatus(profile: profile)
        let workStatus = getWorkCategoryStatus(profile: profile)
        let skillsStatus = getSkillsCategoryStatus(profile: profile)
        let interestsStatus = getInterestsCategoryStatus(profile: profile)
        let certificatesStatus = getCertificatesCategoryStatus(profile: profile)
        let languagesStatus = getLanguagesCategoryStatus(profile: profile)
        let referencesStatus = getReferencesCategoryStatus(profile: profile)
        
        let totalSteps = generalStatus.steps + contactStatus.steps + socialStatus.steps + educationStatus.steps + workStatus.steps + skillsStatus.steps + interestsStatus.steps + certificatesStatus.steps + languagesStatus.steps + referencesStatus.steps + 1
        
        var totalFinishedSteps = generalStatus.finished + contactStatus.finished + socialStatus.finished + educationStatus.finished + workStatus.finished + skillsStatus.finished + interestsStatus.finished + certificatesStatus.finished + languagesStatus.finished + referencesStatus.finished
        
        if profile.photoId != -1 {
            totalFinishedSteps += 1
        }
        
        if totalSteps > 0 {
            return CGFloat(totalFinishedSteps) / CGFloat(totalSteps)
        } else {
            return 0.0
        }
    }
    
    func getGeneralInfoCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 3
        var finished = 0
        
        if !profile.name.isEmpty {
            finished += 1
        }
        
        if !profile.location.isEmpty {
            finished += 1
        }
        
        if !profile.jobTitle.isEmpty {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getContactCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 4
        var finished = 0
        
        if !profile.email.isEmpty {
            finished += 1
        }
        
        if !profile.phone.isEmpty {
            finished += 1
        }
        
        if !profile.websiteLink.isEmpty {
            finished += 1
        }
        
        if profile.websiteQrCodeId != -1 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getSocialCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.socialMediasList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getSkillsCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.skillsList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getInterestsCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.interestsList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getEducationCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.educationsList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getWorkCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.worksList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getCertificatesCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.certificatesList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getLanguagesCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.languagesList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
    
    func getReferencesCategoryStatus (profile: ProfileEntity) -> (steps: Int, finished: Int, progress: CGFloat) {
        let steps = 1
        var finished = 0
        
        if let list = profile.referencesList, list.count > 0 {
            finished += 1
        }
        
        return (steps: steps, finished: finished, progress: CGFloat(finished) / CGFloat(steps))
    }
}
