//
//  CVUpdater.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class CVUpdater {
    
    let profileManager = ProfileManager()
    
    func updateCvIfNeeded (cv: CVEntity, profile: ProfileEntity) async -> (isChanged: Bool, isAiLimitReached: Bool) {
        let language = TextLangDetector.getDefaultLanguage()
        
        var isChangedList: [Bool] = []
        var isAiLimitReachedList: [Bool] = []
        
        let profileDescResult = await updateProfileDescription(cv: cv, profile: profile, language: language)
        isChangedList.append(profileDescResult.isChanged)
        isAiLimitReachedList.append(profileDescResult.isAiLimitReached)
        
        isChangedList.append(updateGeneralData(cv: cv, profile: profile, language: language))
        isChangedList.append(updateContactInfo(cv: cv, profile: profile, language: language))
        isChangedList.append(updateSocialMedia(cv: cv, profile: profile, language: language))
        
        let educationResult = await updateEducation(cv: cv, profile: profile, language: language)
        isChangedList.append(educationResult.isChanged)
        isAiLimitReachedList.append(educationResult.isAiLimitReached)
        
        let workResult = await updateWork(cv: cv, profile: profile, language: language)
        isChangedList.append(workResult.isChanged)
        isAiLimitReachedList.append(workResult.isAiLimitReached)
        
        isChangedList.append(updateLanguages(cv: cv, profile: profile, language: language))
        isChangedList.append(updateSkills(cv: cv, profile: profile, language: language))
        isChangedList.append(updateInterests(cv: cv, profile: profile, language: language))
        isChangedList.append(updateCertificates(cv: cv, profile: profile, language: language))
        isChangedList.append(updateReferences(cv: cv, profile: profile, language: language))
        isChangedList.append(updateQRCodes(cv: cv, profile: profile, language: language))

        DatabaseBox.saveContext()
        
        var isChanged = false
        var isAiLimitReached = false
        for b in isChangedList {
            if b {
                isChanged = true
                break
            }
        }
        for b in isAiLimitReachedList {
            if b {
                isAiLimitReached = true
                break
            }
        }
        return (isChanged, isAiLimitReached)
    }
    
    private func updateProfileDescription (cv: CVEntity, profile: ProfileEntity, language: Language) async -> (isChanged: Bool, isAiLimitReached: Bool) {
        var isChanged = false
        var isAiLimitReached = false
        if let generalBlock = cv.generalBlock, let profileDescBlock = cv.profileDescBlock {
            if profile.jobTitle != generalBlock.jobTitle {
                if AiManager.getAiTextAttempts() > 0 {
//                    if let text = await AIAssistant.generateProfileDescription(currentJob: profile.jobTitle, targetJob: cv.tagretJob, targetInstitution: cv.tagretCompany, language: language.name) {
//                        profileDescBlock.profileDescription = text
//                        AiManager.useAiTextAttempt()
//                        isChanged = true
//                    }
                } else {
                    isAiLimitReached = true
                }
            }
        }
        return (isChanged, isAiLimitReached)
    }
    
    private func updateGeneralData (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let generalBlock = cv.generalBlock {
            if profile.name != generalBlock.name {
                generalBlock.name = profile.name
                isChanged = true
            }
            if profile.location != generalBlock.location {
                generalBlock.location = profile.location
                isChanged = true
            }
            if profile.jobTitle != generalBlock.jobTitle {
                generalBlock.jobTitle = profile.jobTitle
                isChanged = true
            }
            if profile.photoId != generalBlock.photoId {
                generalBlock.photoId = profile.photoId
                isChanged = true
            }
        }
        return isChanged
    }
    
    private func updateContactInfo (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let contactBlock = cv.contactBlock {
            if profile.email != contactBlock.email {
                contactBlock.email = profile.email
                isChanged = true
            }
            if profile.phone != contactBlock.phone {
                contactBlock.phone = profile.phone
                isChanged = true
            }
            if profile.websiteLink != contactBlock.websiteLink {
                contactBlock.websiteLink = profile.websiteLink
                isChanged = true
            }
            if profile.websiteQrCodeId != contactBlock.websiteQrCodeId {
                contactBlock.websiteQrCodeId = profile.websiteQrCodeId
                isChanged = true
            }
        }
        return isChanged
    }
    
    private func updateSocialMedia (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let socialBlock = cv.socialBlock, var list = socialBlock.list, let socialMediasList = profile.socialMediasList {
            
            var entitiesToDelete: [SocialMediaBlockItemEntity] = []
            for cvMedia in list {
                var isActual = false
                for profileMedia in socialMediasList {
                    if cvMedia.entityId == profileMedia.id {
                        isActual = true
                        if profileMedia.link != cvMedia.link {
                            cvMedia.link = profileMedia.link
                            isChanged = true
                        }
                        if profileMedia.qrCodeId != cvMedia.qrCodeId {
                            cvMedia.qrCodeId = profileMedia.qrCodeId
                            isChanged = true
                        }
                        if profileMedia.media != cvMedia.media {
                            cvMedia.media = profileMedia.media
                            isChanged = true
                        }
                        cvMedia.position = profileMedia.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvMedia)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [SocialMediaBlockItemEntity] = []
            for profileMedia in socialMediasList {
                var needsAdding = true
                for cvMedia in list {
                    if profileMedia.id == cvMedia.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = SocialMediaBlockItemEntity(entityId: profileMedia.id, link: profileMedia.link, media: profileMedia.media, qrCodeId: profileMedia.qrCodeId, isAdded: true, position: profileMedia.position, page: socialBlock.page)
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            socialBlock.list = list
        }
        return isChanged
    }
    
    private func updateEducation (cv: CVEntity, profile: ProfileEntity, language: Language) async -> (isChanged: Bool, isAiLimitReached: Bool) {
        var isChanged = false
        var isAiLimitReached = false
        if let educationBlock = cv.educationBlock, var list = educationBlock.list, let educationsList = profile.educationsList {
            
            var entitiesToDelete: [EducationBlockItemEntity] = []
            for cvEducation in list {
                var isActual = false
                for profileEducation in educationsList {
                    if cvEducation.entityId == profileEducation.id {
                        isActual = true
                        
                        var descUpdateNeeded = false
                        
                        if profileEducation.level != cvEducation.level {
                            cvEducation.level = profileEducation.level
                            descUpdateNeeded = true
                            isChanged = true
                        }
                        
                        if profileEducation.institution != cvEducation.institution {
                            cvEducation.institution = profileEducation.institution
                            descUpdateNeeded = true
                            isChanged = true
                        }
                        if profileEducation.logoId != cvEducation.logoId {
                            cvEducation.logoId = profileEducation.logoId
                            isChanged = true
                        }
                        if profileEducation.fieldOfStudy != cvEducation.fieldOfStudy {
                            cvEducation.fieldOfStudy = profileEducation.fieldOfStudy
                            descUpdateNeeded = true
                            isChanged = true
                        }
                        if profileEducation.degree != cvEducation.degree {
                            cvEducation.degree = profileEducation.degree
                            descUpdateNeeded = true
                            isChanged = true
                        }
                        if profileEducation.startDate != cvEducation.startDate {
                            cvEducation.startDate = profileEducation.startDate
                            isChanged = true
                        }
                        if profileEducation.endDate != cvEducation.endDate {
                            cvEducation.endDate = profileEducation.endDate
                            isChanged = true
                        }
                        if profileEducation.isStillLearning != cvEducation.isStillLearning {
                            cvEducation.isStillLearning = profileEducation.isStillLearning
                            isChanged = true
                        }
                        if profileEducation.gpa != cvEducation.gpa {
                            cvEducation.gpa = profileEducation.gpa
                            isChanged = true
                        }
                        if profileEducation.coursework != cvEducation.coursework {
                            cvEducation.coursework = profileEducation.coursework
                            isChanged = true
                        }
                        
                        if descUpdateNeeded {
                            if AiManager.getAiTextAttempts() > 0 {
//                                if let text = await AIAssistant.generateEducationDescription(item: cvEducation, targetJob: cv.tagretJob, targetInstitution: cv.tagretCompany, language: language.name) {
//                                    cvEducation.desc = text
//                                    AiManager.useAiTextAttempt()
//                                    isChanged = true
//                                }
                            } else {
                                isAiLimitReached = true
                            }
                        }
                        
                        cvEducation.position = profileEducation.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvEducation)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [EducationBlockItemEntity] = []
            for profileEducation in educationsList {
                var needsAdding = true
                for cvEducation in list {
                    if profileEducation.id == cvEducation.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = EducationBlockItemEntity(entityId: profileEducation.id, desc: "", level: profileEducation.level, institution: profileEducation.institution, logoId: profileEducation.logoId, fieldOfStudy: profileEducation.fieldOfStudy, degree: profileEducation.degree, startDate: profileEducation.startDate, endDate: profileEducation.endDate, isStillLearning: profileEducation.isStillLearning, gpa: profileEducation.gpa, coursework: profileEducation.coursework, isAdded: true, position: profileEducation.position, page: educationBlock.page)
                    if AiManager.getAiTextAttempts() > 0 {
//                        if let text = await AIAssistant.generateEducationDescription(item: item, targetJob: cv.tagretJob, targetInstitution: cv.tagretCompany, language: language.name) {
//                            item.desc = text
//                            AiManager.useAiTextAttempt()
//                        }
                    } else {
                        isAiLimitReached = true
                    }
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            educationBlock.list = list
        }
        return (isChanged, isAiLimitReached)
    }
    
    private func updateWork (cv: CVEntity, profile: ProfileEntity, language: Language) async -> (isChanged: Bool, isAiLimitReached: Bool) {
        if let workBlock = cv.workBlock {
            
        }
        var isChanged = false
        var isAiLimitReached = false
        if let workBlock = cv.workBlock, var list = workBlock.list, let worksList = profile.worksList {
            
            var entitiesToDelete: [WorkBlockItemEntity] = []
            for cvWork in list {
                var isActual = false
                for profileWork in worksList {
                    if cvWork.entityId == profileWork.id {
                        isActual = true
                        
                        var descUpdateNeeded = false
                        
                        if profileWork.jobTitle != cvWork.jobTitle {
                            cvWork.jobTitle = profileWork.jobTitle
                            descUpdateNeeded = true
                            isChanged = true
                        }
                        
                        if profileWork.company != cvWork.company {
                            cvWork.company = profileWork.company
                            descUpdateNeeded = true
                            isChanged = true
                        }
                        if profileWork.iconId != cvWork.iconId {
                            cvWork.iconId = profileWork.iconId
                            isChanged = true
                        }
                        if profileWork.location != cvWork.location {
                            cvWork.location = profileWork.location
                            isChanged = true
                        }
                        if profileWork.startDate != cvWork.startDate {
                            cvWork.startDate = profileWork.startDate
                            isChanged = true
                        }
                        if profileWork.endDate != cvWork.endDate {
                            cvWork.endDate = profileWork.endDate
                            isChanged = true
                        }
                        if profileWork.isStillWorking != cvWork.isStillWorking {
                            cvWork.isStillWorking = profileWork.isStillWorking
                            isChanged = true
                        }
                        if profileWork.responsibilities != cvWork.responsibilities {
                            cvWork.responsibilities = profileWork.responsibilities
                            isChanged = true
                        }
                        if profileWork.remote != cvWork.remote {
                            cvWork.remote = profileWork.remote
                            isChanged = true
                        }
                        if profileWork.partTime != cvWork.partTime {
                            cvWork.partTime = profileWork.partTime
                            isChanged = true
                        }
                        
                        if descUpdateNeeded {
                            if AiManager.getAiTextAttempts() > 0 {
//                                if let text = await AIAssistant.generateWorkDescription(item: cvWork, targetJob: cv.tagretJob, targetInstitution: cv.tagretCompany, language: language.name) {
//                                    cvWork.desc = text
//                                    AiManager.useAiTextAttempt()
//                                    isChanged = true
//                                }
                            } else {
                                isAiLimitReached = true
                            }
                        }
                        
                        cvWork.position = profileWork.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvWork)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [WorkBlockItemEntity] = []
            for profileWork in worksList {
                var needsAdding = true
                for cvWork in list {
                    if profileWork.id == cvWork.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = WorkBlockItemEntity(entityId: profileWork.id, desc: "", jobTitle: profileWork.jobTitle, company: profileWork.company, iconId: profileWork.iconId, location: profileWork.location, startDate: profileWork.startDate, endDate: profileWork.endDate, isStillWorking: profileWork.isStillWorking, responsibilities: profileWork.responsibilities, remote: profileWork.remote, partTime: profileWork.partTime, isAdded: true, position: profileWork.position, page: workBlock.page)
                    if AiManager.getAiTextAttempts() > 0 {
//                        if let text = await AIAssistant.generateWorkDescription(item: item, targetJob: cv.tagretJob, targetInstitution: cv.tagretCompany, language: language.name) {
//                            item.desc = text
//                            AiManager.useAiTextAttempt()
//                        }
                    } else {
                        isAiLimitReached = true
                    }
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            workBlock.list = list
        }
        return (isChanged, isAiLimitReached)
    }
    
    private func updateLanguages (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let languagesBlock = cv.languagesBlock, var list = languagesBlock.list, let languagesList = profile.languagesList {
            
            var entitiesToDelete: [LanguageBlockItemEntity] = []
            for cvLanguage in list {
                var isActual = false
                for profileLanguage in languagesList {
                    if cvLanguage.entityId == profileLanguage.id {
                        isActual = true
                        if profileLanguage.langId != cvLanguage.langId {
                            cvLanguage.langId = profileLanguage.langId
                            isChanged = true
                        }
                        if profileLanguage.name != cvLanguage.name {
                            cvLanguage.name = profileLanguage.name
                            isChanged = true
                        }
                        if profileLanguage.level != cvLanguage.level {
                            cvLanguage.level = profileLanguage.level
                            isChanged = true
                        }
                        cvLanguage.position = profileLanguage.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvLanguage)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [LanguageBlockItemEntity] = []
            for profileLanguage in languagesList {
                var needsAdding = true
                for cvLanguage in list {
                    if profileLanguage.id == cvLanguage.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = LanguageBlockItemEntity(entityId: profileLanguage.id, langId: profileLanguage.langId, name: profileLanguage.name, level: profileLanguage.level, isAdded: true, position: profileLanguage.position, page: languagesBlock.page)
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            languagesBlock.list = list
        }
        return isChanged
    }
    
    private func updateSkills (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let skillsBlock = cv.skillsBlock, var list = skillsBlock.list, let skillsList = profile.skillsList {
            
            var entitiesToDelete: [SkillBlockItemEntity] = []
            for cvSkill in list {
                var isActual = false
                for profileSkill in skillsList {
                    if cvSkill.entityId == profileSkill.id {
                        isActual = true
                        if profileSkill.name != cvSkill.name {
                            cvSkill.name = profileSkill.name
                            isChanged = true
                        }
                        if profileSkill.level != cvSkill.level {
                            cvSkill.level = profileSkill.level
                            isChanged = true
                        }
                        if profileSkill.category != cvSkill.category {
                            cvSkill.category = profileSkill.category
                            isChanged = true
                        }
                        if profileSkill.iconId != cvSkill.iconId {
                            cvSkill.iconId = profileSkill.iconId
                            isChanged = true
                        }
                        cvSkill.position = profileSkill.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvSkill)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [SkillBlockItemEntity] = []
            for profileSkill in skillsList {
                var needsAdding = true
                for cvSkill in list {
                    if profileSkill.id == cvSkill.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = SkillBlockItemEntity(entityId: profileSkill.id, name: profileSkill.name, level: profileSkill.level, iconId: profileSkill.iconId, category: profileSkill.category, isAdded: true, position: profileSkill.position)
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            skillsBlock.list = list
        }
        return isChanged
    }
    
    private func updateInterests (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let interestsBlock = cv.interestsBlock, var list = interestsBlock.list, let interestsList = profile.interestsList {
            
            var entitiesToDelete: [InterestBlockItemEntity] = []
            for cvInterest in list {
                var isActual = false
                for profileInterest in interestsList {
                    if cvInterest.entityId == profileInterest.id {
                        isActual = true
                        if profileInterest.name != cvInterest.name {
                            cvInterest.name = profileInterest.name
                            isChanged = true
                        }
                        cvInterest.position = profileInterest.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvInterest)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [InterestBlockItemEntity] = []
            for profileInterest in interestsList {
                var needsAdding = true
                for cvInterest in list {
                    if profileInterest.id == cvInterest.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = InterestBlockItemEntity(entityId: profileInterest.id, name: profileInterest.name, isAdded: true, position: profileInterest.position)
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            interestsBlock.list = list
        }
        return isChanged
    }
    
    private func updateCertificates (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let certificatesBlock = cv.certificatesBlock, var list = certificatesBlock.list, let certificatesList = profile.certificatesList {
            
            var entitiesToDelete: [CertificateBlockItemEntity] = []
            for cvCertificate in list {
                var isActual = false
                for profileCertificate in certificatesList {
                    if cvCertificate.entityId == profileCertificate.id {
                        isActual = true
                        if profileCertificate.name != cvCertificate.name {
                            cvCertificate.name = profileCertificate.name
                            isChanged = true
                        }
                        cvCertificate.position = profileCertificate.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvCertificate)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [CertificateBlockItemEntity] = []
            for profileCertificate in certificatesList {
                var needsAdding = true
                for cvCertificate in list {
                    if profileCertificate.id == cvCertificate.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = CertificateBlockItemEntity(entityId: profileCertificate.id, name: profileCertificate.name, isAdded: true, position: profileCertificate.position)
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            certificatesBlock.list = list
        }
        return isChanged
    }
    
    private func updateReferences (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let referencesBlock = cv.referencesBlock, var list = referencesBlock.list, let referencesList = profile.referencesList {
            
            var entitiesToDelete: [ReferenceBlockItemEntity] = []
            for cvReference in list {
                var isActual = false
                for profileReference in referencesList {
                    if cvReference.entityId == profileReference.id {
                        isActual = true
                        if profileReference.referralName != cvReference.referralName {
                            cvReference.referralName = profileReference.referralName
                            isChanged = true
                        }
                        if profileReference.company != cvReference.company {
                            cvReference.company = profileReference.company
                            isChanged = true
                        }
                        if profileReference.email != cvReference.email {
                            cvReference.email = profileReference.email
                            isChanged = true
                        }
                        if profileReference.phone != cvReference.phone {
                            cvReference.phone = profileReference.phone
                            isChanged = true
                        }
                        cvReference.position = profileReference.position
                    }
                }
                if !isActual {
                    entitiesToDelete.append(cvReference)
                }
            }
            
            if entitiesToDelete.count > 0 {
                for entity in entitiesToDelete {
                    list.removeAll{$0.id == entity.id}
                    DatabaseBox.deleteEntity(item: entity)
                }
                isChanged = true
            }
            
            var entitiesToAppend: [ReferenceBlockItemEntity] = []
            for profileReference in referencesList {
                var needsAdding = true
                for cvReference in list {
                    if profileReference.id == cvReference.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    let item = ReferenceBlockItemEntity(entityId: profileReference.id, referralName: profileReference.referralName, company: profileReference.company, email: profileReference.email, phone: profileReference.phone, isAdded: true, position: profileReference.position)
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                    isChanged = true
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            referencesBlock.list = list
        }
        return isChanged
    }
    
    private func updateQRCodes (cv: CVEntity, profile: ProfileEntity, language: Language) -> Bool {
        var isChanged = false
        if let qrCodesBlock = cv.qrCodesBlock {
            
            var items: [Int] = []
            if profile.websiteQrCodeId != -1 {
                items.append(profile.websiteQrCodeId)
            }
            
            if let list = profile.socialMediasList {
                for media in list {
                    if media.qrCodeId != -1 {
                        items.append(media.qrCodeId)
                    }
                }
            }
            
            isChanged = items.sorted() != qrCodesBlock.qrCodes.sorted()
            
            qrCodesBlock.qrCodes = items
        }
        return isChanged
    }
}
