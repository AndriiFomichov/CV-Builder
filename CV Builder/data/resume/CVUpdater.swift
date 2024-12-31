//
//  CVUpdater.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class CVUpdater {
    
    let profileManager = ProfileManager()
    
    func getProfileUpdatedChanges (cv: CVEntity, profile: ProfileEntity) -> (isChanged: Bool, changes: [CVChange]) {
        var isChanged = false
        var list: [CVChange] = []
        
        let textAttempts = AiManager.getAiTextAttempts()
        
        list.append(getGeneralDataChange(cv: cv, profile: profile))
        list.append(getProfileDescChange(cv: cv, profile: profile))
        list.append(getEducationChange(cv: cv, profile: profile))
        list.append(getWorkChange(cv: cv, profile: profile))
        list.append(getLanguagesChange(cv: cv, profile: profile))
        list.append(getSkillsChange(cv: cv, profile: profile))
        list.append(getInterestsChange(cv: cv, profile: profile))
        list.append(getContactsChange(cv: cv, profile: profile))
        list.append(getSocialMediaChange(cv: cv, profile: profile))
        list.append(getCertificatesChange(cv: cv, profile: profile))
        list.append(getReferencesChange(cv: cv, profile: profile))
        list.append(getQRChange(cv: cv, profile: profile))
        list.append(getCoverLetterChange(cv: cv, profile: profile))
        
        var aiAttemptsUsed = 0
        for change in list {
            if change.descriptionGenerationNeeded {
                if aiAttemptsUsed + change.descriptionGenerationsCount <= textAttempts {
                    change.descriptionGenerationEnabled = true
                    aiAttemptsUsed += change.descriptionGenerationsCount
                }
            }
        }
        
        for change in list {
            if change.isChangeEnabled {
                isChanged = true
                break
            }
        }
        
        return (isChanged, list)
    }
    
    private func getGeneralDataChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let block = cv.generalBlock {
            if profile.name != block.name {
                changeNeeded = true
            }
            if profile.location != block.location {
                changeNeeded = true
            }
            if profile.jobTitle != block.jobTitle {
                changeNeeded = true
            }
            if profile.photoId != block.photoId {
                changeNeeded = true
            }
        }
        
        return CVChange(blockId: 0, blockName: NSLocalizedString("content_category_0", comment: ""), blockIcon: "person.crop.circle", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: "")
    }
    
    private func getProfileDescChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        var descNeeded = false
        var aiAttemptsNeeded = 0
        
        if let generalBlock = cv.generalBlock {
            if profile.jobTitle != generalBlock.jobTitle {
                changeNeeded = true
                if !profile.jobTitle.isEmpty {
                    descNeeded = true
                }
                aiAttemptsNeeded = 1
            }
        }
        
        return CVChange(blockId: 1, blockName: NSLocalizedString("content_category_1", comment: ""), blockIcon: "text.bubble.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: descNeeded, descriptionGenerationEnabled: false, descriptionGenerationsCount: aiAttemptsNeeded, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getEducationChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        var descNeeded = false
        var aiAttemptsNeeded = 0
        
        if let educationBlock = cv.educationBlock, let list = educationBlock.list, let educationsList = profile.educationsList {
            
            var entitiesToDelete = 0
            
            for cvEducation in list {
                
                var isActual = false
                
                for profileEducation in educationsList {
                    if cvEducation.entityId == profileEducation.id {
                        isActual = true
                        
                        var descUpdateNeeded = false
                        
                        if profileEducation.level != cvEducation.level {
                            if !profileEducation.level.isEmpty {
                                descUpdateNeeded = true
                            }
                            changeNeeded = true
                        }
                        
                        if profileEducation.institution != cvEducation.institution {
                            if !profileEducation.institution.isEmpty {
                                descUpdateNeeded = true
                            }
                            changeNeeded = true
                        }
                        if profileEducation.logoId != cvEducation.logoId {
                            changeNeeded = true
                        }
                        if profileEducation.fieldOfStudy != cvEducation.fieldOfStudy {
                            if !profileEducation.fieldOfStudy.isEmpty {
                                descUpdateNeeded = true
                            }
                            changeNeeded = true
                        }
                        if profileEducation.degree != cvEducation.degree {
                            if !profileEducation.degree.isEmpty {
                                descUpdateNeeded = true
                            }
                            changeNeeded = true
                        }
                        if profileEducation.startDate != cvEducation.startDate {
                            changeNeeded = true
                        }
                        if profileEducation.endDate != cvEducation.endDate {
                            changeNeeded = true
                        }
                        if profileEducation.isStillLearning != cvEducation.isStillLearning {
                            changeNeeded = true
                        }
                        if profileEducation.gpa != cvEducation.gpa {
                            changeNeeded = true
                        }
                        if profileEducation.coursework != cvEducation.coursework {
                            changeNeeded = true
                        }
                        
                        if descUpdateNeeded {
                            aiAttemptsNeeded += 1
                            descNeeded = true
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileEducation in educationsList {
                var needsAdding = true
                for cvEducation in list {
                    if profileEducation.id == cvEducation.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                    aiAttemptsNeeded += 1
                    descNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 2, blockName: NSLocalizedString("content_category_2", comment: ""), blockIcon: "graduationcap.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: descNeeded, descriptionGenerationEnabled: false, descriptionGenerationsCount: aiAttemptsNeeded, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getWorkChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        var descNeeded = false
        var aiAttemptsNeeded = 0
        
        if let workBlock = cv.workBlock, let list = workBlock.list, let worksList = profile.worksList {
            
            var entitiesToDelete = 0
            for cvWork in list {
                var isActual = false
                for profileWork in worksList {
                    if cvWork.entityId == profileWork.id {
                        isActual = true
                        
                        var descUpdateNeeded = false
                        
                        if profileWork.jobTitle != cvWork.jobTitle {
                            if !profileWork.jobTitle.isEmpty {
                                descUpdateNeeded = true
                            }
                            changeNeeded = true
                        }
                        
                        if profileWork.company != cvWork.company {
                            if !profileWork.company.isEmpty {
                                descUpdateNeeded = true
                            }
                            changeNeeded = true
                        }
                        if profileWork.iconId != cvWork.iconId {
                            changeNeeded = true
                        }
                        if profileWork.location != cvWork.location {
                            changeNeeded = true
                        }
                        if profileWork.startDate != cvWork.startDate {
                            changeNeeded = true
                        }
                        if profileWork.endDate != cvWork.endDate {
                            changeNeeded = true
                        }
                        if profileWork.isStillWorking != cvWork.isStillWorking {
                            changeNeeded = true
                        }
                        if profileWork.responsibilities != cvWork.responsibilities {
                            if !profileWork.responsibilities.isEmpty {
                                descUpdateNeeded = true
                            }
                            changeNeeded = true
                        }
                        if profileWork.remote != cvWork.remote {
                            changeNeeded = true
                        }
                        if profileWork.partTime != cvWork.partTime {
                            changeNeeded = true
                        }
                        
                        if descUpdateNeeded {
                            changeNeeded = true
                            descNeeded = true
                            aiAttemptsNeeded += 1
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileWork in worksList {
                var needsAdding = true
                for cvWork in list {
                    if profileWork.id == cvWork.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                    aiAttemptsNeeded += 1
                    descNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 3, blockName: NSLocalizedString("content_category_3", comment: ""), blockIcon: "briefcase.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: descNeeded, descriptionGenerationEnabled: false, descriptionGenerationsCount: aiAttemptsNeeded, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getLanguagesChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let languagesBlock = cv.languagesBlock, let list = languagesBlock.list, let languagesList = profile.languagesList {
            
            var entitiesToDelete = 0
            for cvLanguage in list {
                var isActual = false
                for profileLanguage in languagesList {
                    if cvLanguage.entityId == profileLanguage.id {
                        isActual = true
                        if profileLanguage.langId != cvLanguage.langId {
                            changeNeeded = true
                        }
                        if profileLanguage.name != cvLanguage.name {
                            changeNeeded = true
                        }
                        if profileLanguage.level != cvLanguage.level {
                            changeNeeded = true
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileLanguage in languagesList {
                var needsAdding = true
                for cvLanguage in list {
                    if profileLanguage.id == cvLanguage.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 4, blockName: NSLocalizedString("content_category_4", comment: ""), blockIcon: "globe", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getSkillsChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let skillsBlock = cv.skillsBlock, let list = skillsBlock.list, let skillsList = profile.skillsList {
            
            var entitiesToDelete = 0
            for cvSkill in list {
                var isActual = false
                for profileSkill in skillsList {
                    if cvSkill.entityId == profileSkill.id {
                        isActual = true
                        if profileSkill.name != cvSkill.name {
                            changeNeeded = true
                        }
                        if profileSkill.level != cvSkill.level {
                            changeNeeded = true
                        }
                        if profileSkill.category != cvSkill.category {
                            changeNeeded = true
                        }
                        if profileSkill.iconId != cvSkill.iconId {
                            changeNeeded = true
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileSkill in skillsList {
                var needsAdding = true
                for cvSkill in list {
                    if profileSkill.id == cvSkill.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 5, blockName: NSLocalizedString("content_category_5", comment: ""), blockIcon: "lightbulb.max.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getInterestsChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let interestsBlock = cv.interestsBlock, let list = interestsBlock.list, let interestsList = profile.interestsList {
            
            var entitiesToDelete = 0
            for cvInterest in list {
                var isActual = false
                for profileInterest in interestsList {
                    if cvInterest.entityId == profileInterest.id {
                        isActual = true
                        if profileInterest.name != cvInterest.name {
                            changeNeeded = true
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileInterest in interestsList {
                var needsAdding = true
                for cvInterest in list {
                    if profileInterest.id == cvInterest.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 6, blockName: NSLocalizedString("content_category_6", comment: ""), blockIcon: "heart.circle", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getContactsChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let contactBlock = cv.contactBlock {
            if profile.email != contactBlock.email {
                changeNeeded = true
            }
            if profile.phone != contactBlock.phone {
                changeNeeded = true
            }
            if profile.websiteLink != contactBlock.websiteLink {
                changeNeeded = true
            }
            if profile.websiteQrCodeId != contactBlock.websiteQrCodeId {
                changeNeeded = true
            }
        }
        
        return CVChange(blockId: 7, blockName: NSLocalizedString("content_category_7", comment: ""), blockIcon: "paperplane.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getSocialMediaChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let socialBlock = cv.socialBlock, let list = socialBlock.list, let socialMediasList = profile.socialMediasList {
            
            var entitiesToDelete = 0
            for cvMedia in list {
                var isActual = false
                for profileMedia in socialMediasList {
                    if cvMedia.entityId == profileMedia.id {
                        isActual = true
                        if profileMedia.link != cvMedia.link {
                            changeNeeded = true
                        }
                        if profileMedia.qrCodeId != cvMedia.qrCodeId {
                            changeNeeded = true
                        }
                        if profileMedia.media != cvMedia.media {
                            changeNeeded = true
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileMedia in socialMediasList {
                var needsAdding = true
                for cvMedia in list {
                    if profileMedia.id == cvMedia.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 8, blockName: NSLocalizedString("content_category_8", comment: ""), blockIcon: "text.bubble.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getCertificatesChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let certificatesBlock = cv.certificatesBlock, let list = certificatesBlock.list, let certificatesList = profile.certificatesList {
            
            var entitiesToDelete = 0
            for cvCertificate in list {
                var isActual = false
                for profileCertificate in certificatesList {
                    if cvCertificate.entityId == profileCertificate.id {
                        isActual = true
                        if profileCertificate.name != cvCertificate.name {
                            changeNeeded = true
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileCertificate in certificatesList {
                var needsAdding = true
                for cvCertificate in list {
                    if profileCertificate.id == cvCertificate.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 9, blockName: NSLocalizedString("content_category_9", comment: ""), blockIcon: "text.page.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getReferencesChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
        if let referencesBlock = cv.referencesBlock, let list = referencesBlock.list, let referencesList = profile.referencesList {
            
            var entitiesToDelete = 0
            for cvReference in list {
                var isActual = false
                for profileReference in referencesList {
                    if cvReference.entityId == profileReference.id {
                        isActual = true
                        if profileReference.referralName != cvReference.referralName {
                            changeNeeded = true
                        }
                        if profileReference.company != cvReference.company {
                            changeNeeded = true
                        }
                        if profileReference.email != cvReference.email {
                            changeNeeded = true
                        }
                        if profileReference.phone != cvReference.phone {
                            changeNeeded = true
                        }
                    }
                }
                if !isActual {
                    entitiesToDelete += 1
                }
            }
            
            if entitiesToDelete > 0 {
                changeNeeded = true
            }
            
            for profileReference in referencesList {
                var needsAdding = true
                for cvReference in list {
                    if profileReference.id == cvReference.entityId {
                        needsAdding = false
                        break
                    }
                }
                if needsAdding {
                    changeNeeded = true
                }
            }
        }
        
        return CVChange(blockId: 10, blockName: NSLocalizedString("content_category_10", comment: ""), blockIcon: "star.bubble.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getQRChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        
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
            
            changeNeeded = items.sorted() != qrCodesBlock.qrCodes.sorted()
        }
        
        return CVChange(blockId: 11, blockName: NSLocalizedString("content_category_11", comment: ""), blockIcon: "qrcode", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: false, descriptionGenerationEnabled: false, descriptionGenerationsCount: 0, descriptionGenerationsText: NSLocalizedString("generate_description", comment: ""))
    }
    
    private func getCoverLetterChange (cv: CVEntity, profile: ProfileEntity) -> CVChange {
        var changeNeeded = false
        var descNeeded = false
        var aiAttemptsNeeded = 0
        
        if let generalBlock = cv.generalBlock, let coverLetter = cv.coverLetter, !coverLetter.text.isEmpty {
            if profile.jobTitle != generalBlock.jobTitle {
                changeNeeded = true
                descNeeded = true
                aiAttemptsNeeded = 1
            }
        }
        
        return CVChange(blockId: 12, blockName: NSLocalizedString("cover_letter", comment: ""), blockIcon: "text.document.fill", isChangeNeeded: changeNeeded, isChangeEnabled: changeNeeded, descriptionGenerationNeeded: descNeeded, descriptionGenerationEnabled: false, descriptionGenerationsCount: aiAttemptsNeeded, descriptionGenerationsText: NSLocalizedString("generate_text", comment: ""))
    }
    
    func updateCv (cv: CVEntity, profile: ProfileEntity, changes: [CVChange]) async {
        let language = PreloadedDatabase.getLanguageById(id: cv.language)
//        let language = TextLangDetector.getDefaultLanguage()
        let style = PreloadedDatabase.getStyleId(id: cv.style)
        
        await updateProfileDescription(cv: cv, profile: profile, language: language, change: changes[1])
        updateGeneralData(cv: cv, profile: profile, language: language, change: changes[0])
        await updateEducation(cv: cv, profile: profile, language: language, isBulletedList: style.educationDescritpionAsBulleted, change: changes[2])
        await updateWork(cv: cv, profile: profile, language: language, isBulletedList: style.educationDescritpionAsBulleted, change: changes[3])
        updateLanguages(cv: cv, profile: profile, language: language, change: changes[4])
        updateSkills(cv: cv, profile: profile, language: language, change: changes[5])
        updateInterests(cv: cv, profile: profile, language: language, change: changes[6])
        updateContactInfo(cv: cv, profile: profile, language: language, change: changes[7])
        updateSocialMedia(cv: cv, profile: profile, language: language, change: changes[8])
        updateCertificates(cv: cv, profile: profile, language: language, change: changes[9])
        updateReferences(cv: cv, profile: profile, language: language, change: changes[10])
        updateQRCodes(cv: cv, profile: profile, language: language, change: changes[11])
        await updateCoverLetter(cv: cv, profile: profile, language: language, change: changes[12])
        
//        cv.language = language.langId
        
        DatabaseBox.saveContext()
    }
    
    private func updateProfileDescription (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) async {
        if let generalBlock = cv.generalBlock, let profileDescBlock = cv.profileDescBlock, change.isChangeEnabled {
            if profile.jobTitle != generalBlock.jobTitle {
                if AiManager.getAiTextAttempts() > 0, change.descriptionGenerationEnabled {
                    if let text = await AIAssistant.generateProfileDescription(currentJob: profile.jobTitle, targetJob: cv.targetJob, targetInstitution: cv.targetCompany, targetJobDescription: cv.targetJobDescription, language: language.name) {
                        profileDescBlock.profileDescription = text
//                        AiManager.useAiTextAttempt()
                    }
                }
            }
        }
    }
    
    private func updateGeneralData (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let generalBlock = cv.generalBlock, change.isChangeEnabled {
            if profile.name != generalBlock.name {
                generalBlock.name = profile.name
            }
            if profile.location != generalBlock.location {
                generalBlock.location = profile.location
            }
            if profile.jobTitle != generalBlock.jobTitle {
                generalBlock.jobTitle = profile.jobTitle
            }
            if profile.photoId != generalBlock.photoId {
                generalBlock.photoId = profile.photoId
            }
        }
    }
    
    private func updateContactInfo (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let contactBlock = cv.contactBlock, change.isChangeEnabled {
            if profile.email != contactBlock.email {
                contactBlock.email = profile.email
            }
            if profile.phone != contactBlock.phone {
                contactBlock.phone = profile.phone
            }
            if profile.websiteLink != contactBlock.websiteLink {
                contactBlock.websiteLink = profile.websiteLink
            }
            if profile.websiteQrCodeId != contactBlock.websiteQrCodeId {
                contactBlock.websiteQrCodeId = profile.websiteQrCodeId
            }
        }
    }
    
    private func updateSocialMedia (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let socialBlock = cv.socialBlock, var list = socialBlock.list, let socialMediasList = profile.socialMediasList, change.isChangeEnabled {
            
            var entitiesToDelete: [SocialMediaBlockItemEntity] = []
            for cvMedia in list {
                var isActual = false
                for profileMedia in socialMediasList {
                    if cvMedia.entityId == profileMedia.id {
                        isActual = true
                        if profileMedia.link != cvMedia.link {
                            cvMedia.link = profileMedia.link
                        }
                        if profileMedia.qrCodeId != cvMedia.qrCodeId {
                            cvMedia.qrCodeId = profileMedia.qrCodeId
                        }
                        if profileMedia.media != cvMedia.media {
                            cvMedia.media = profileMedia.media
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
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            socialBlock.list = list
        }
    }
    
    private func updateEducation (cv: CVEntity, profile: ProfileEntity, language: Language, isBulletedList: Bool, change: CVChange) async {
        if let educationBlock = cv.educationBlock, var list = educationBlock.list, let educationsList = profile.educationsList, change.isChangeEnabled {
            
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
                        }
                        
                        if profileEducation.institution != cvEducation.institution {
                            cvEducation.institution = profileEducation.institution
                            descUpdateNeeded = true
                        }
                        if profileEducation.logoId != cvEducation.logoId {
                            cvEducation.logoId = profileEducation.logoId
                        }
                        if profileEducation.fieldOfStudy != cvEducation.fieldOfStudy {
                            cvEducation.fieldOfStudy = profileEducation.fieldOfStudy
                            descUpdateNeeded = true
                        }
                        if profileEducation.degree != cvEducation.degree {
                            cvEducation.degree = profileEducation.degree
                            descUpdateNeeded = true
                        }
                        if profileEducation.startDate != cvEducation.startDate {
                            cvEducation.startDate = profileEducation.startDate
                        }
                        if profileEducation.endDate != cvEducation.endDate {
                            cvEducation.endDate = profileEducation.endDate
                        }
                        if profileEducation.isStillLearning != cvEducation.isStillLearning {
                            cvEducation.isStillLearning = profileEducation.isStillLearning
                        }
                        if profileEducation.gpa != cvEducation.gpa {
                            cvEducation.gpa = profileEducation.gpa
                        }
                        if profileEducation.coursework != cvEducation.coursework {
                            cvEducation.coursework = profileEducation.coursework
                        }
                        
                        if descUpdateNeeded {
                            if AiManager.getAiTextAttempts() > 0, change.descriptionGenerationEnabled {
                                if let text = await AIAssistant.generateEducationDescription(item: cvEducation, targetJob: cv.targetJob, targetInstitution: cv.targetCompany, targetJobDescription: cv.targetJobDescription, language: language.name, isBulletedList: isBulletedList) {
                                    cvEducation.desc = text
//                                    AiManager.useAiTextAttempt()
                                }
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
                    if AiManager.getAiTextAttempts() > 0, change.descriptionGenerationEnabled {
                        if let text = await AIAssistant.generateEducationDescription(item: item, targetJob: cv.targetJob, targetInstitution: cv.targetCompany, targetJobDescription: cv.targetJobDescription, language: language.name, isBulletedList: isBulletedList) {
                            item.desc = text
//                            AiManager.useAiTextAttempt()
                        }
                    }
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            educationBlock.list = list
        }
    }
    
    private func updateWork (cv: CVEntity, profile: ProfileEntity, language: Language, isBulletedList: Bool, change: CVChange) async {
        if let workBlock = cv.workBlock, var list = workBlock.list, let worksList = profile.worksList, change.isChangeEnabled {
            
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
                        }
                        
                        if profileWork.company != cvWork.company {
                            cvWork.company = profileWork.company
                            descUpdateNeeded = true
                        }
                        if profileWork.iconId != cvWork.iconId {
                            cvWork.iconId = profileWork.iconId
                        }
                        if profileWork.location != cvWork.location {
                            cvWork.location = profileWork.location
                        }
                        if profileWork.startDate != cvWork.startDate {
                            cvWork.startDate = profileWork.startDate
                        }
                        if profileWork.endDate != cvWork.endDate {
                            cvWork.endDate = profileWork.endDate
                        }
                        if profileWork.isStillWorking != cvWork.isStillWorking {
                            cvWork.isStillWorking = profileWork.isStillWorking
                        }
                        if profileWork.responsibilities != cvWork.responsibilities {
                            cvWork.responsibilities = profileWork.responsibilities
                        }
                        if profileWork.remote != cvWork.remote {
                            cvWork.remote = profileWork.remote
                        }
                        if profileWork.partTime != cvWork.partTime {
                            cvWork.partTime = profileWork.partTime
                        }
                        
                        if descUpdateNeeded {
                            if AiManager.getAiTextAttempts() > 0, change.descriptionGenerationEnabled {
                                if let text = await AIAssistant.generateWorkDescription(item: cvWork, targetJob: cv.targetJob, targetInstitution: cv.targetCompany, targetJobDescription: cv.targetJobDescription, language: language.name, isBulletedList: isBulletedList) {
                                    cvWork.desc = text
//                                    AiManager.useAiTextAttempt()
                                }
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
                    if AiManager.getAiTextAttempts() > 0, change.descriptionGenerationEnabled {
                        if let text = await AIAssistant.generateWorkDescription(item: item, targetJob: cv.targetJob, targetInstitution: cv.targetCompany, targetJobDescription: cv.targetJobDescription, language: language.name, isBulletedList: isBulletedList) {
                            item.desc = text
//                            AiManager.useAiTextAttempt()
                        }
                    }
                    DatabaseBox.saveEntity(item: item)
                    entitiesToAppend.append(item)
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            workBlock.list = list
        }
    }
    
    private func updateLanguages (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let languagesBlock = cv.languagesBlock, var list = languagesBlock.list, let languagesList = profile.languagesList, change.isChangeEnabled {
            
            var entitiesToDelete: [LanguageBlockItemEntity] = []
            for cvLanguage in list {
                var isActual = false
                for profileLanguage in languagesList {
                    if cvLanguage.entityId == profileLanguage.id {
                        isActual = true
                        if profileLanguage.langId != cvLanguage.langId {
                            cvLanguage.langId = profileLanguage.langId
                        }
                        if profileLanguage.name != cvLanguage.name {
                            cvLanguage.name = profileLanguage.name
                        }
                        if profileLanguage.level != cvLanguage.level {
                            cvLanguage.level = profileLanguage.level
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
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            languagesBlock.list = list
        }
    }
    
    private func updateSkills (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let skillsBlock = cv.skillsBlock, var list = skillsBlock.list, let skillsList = profile.skillsList, change.isChangeEnabled {
            
            var entitiesToDelete: [SkillBlockItemEntity] = []
            for cvSkill in list {
                var isActual = false
                for profileSkill in skillsList {
                    if cvSkill.entityId == profileSkill.id {
                        isActual = true
                        if profileSkill.name != cvSkill.name {
                            cvSkill.name = profileSkill.name
                        }
                        if profileSkill.level != cvSkill.level {
                            cvSkill.level = profileSkill.level
                        }
                        if profileSkill.category != cvSkill.category {
                            cvSkill.category = profileSkill.category
                        }
                        if profileSkill.iconId != cvSkill.iconId {
                            cvSkill.iconId = profileSkill.iconId
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
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            skillsBlock.list = list
        }
    }
    
    private func updateInterests (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let interestsBlock = cv.interestsBlock, var list = interestsBlock.list, let interestsList = profile.interestsList, change.isChangeEnabled {
            
            var entitiesToDelete: [InterestBlockItemEntity] = []
            for cvInterest in list {
                var isActual = false
                for profileInterest in interestsList {
                    if cvInterest.entityId == profileInterest.id {
                        isActual = true
                        if profileInterest.name != cvInterest.name {
                            cvInterest.name = profileInterest.name
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
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            interestsBlock.list = list
        }
    }
    
    private func updateCertificates (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let certificatesBlock = cv.certificatesBlock, var list = certificatesBlock.list, let certificatesList = profile.certificatesList, change.isChangeEnabled {
            
            var entitiesToDelete: [CertificateBlockItemEntity] = []
            for cvCertificate in list {
                var isActual = false
                for profileCertificate in certificatesList {
                    if cvCertificate.entityId == profileCertificate.id {
                        isActual = true
                        if profileCertificate.name != cvCertificate.name {
                            cvCertificate.name = profileCertificate.name
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
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            certificatesBlock.list = list
        }
    }
    
    private func updateReferences (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let referencesBlock = cv.referencesBlock, var list = referencesBlock.list, let referencesList = profile.referencesList, change.isChangeEnabled {
            
            var entitiesToDelete: [ReferenceBlockItemEntity] = []
            for cvReference in list {
                var isActual = false
                for profileReference in referencesList {
                    if cvReference.entityId == profileReference.id {
                        isActual = true
                        if profileReference.referralName != cvReference.referralName {
                            cvReference.referralName = profileReference.referralName
                        }
                        if profileReference.company != cvReference.company {
                            cvReference.company = profileReference.company
                        }
                        if profileReference.email != cvReference.email {
                            cvReference.email = profileReference.email
                        }
                        if profileReference.phone != cvReference.phone {
                            cvReference.phone = profileReference.phone
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
                }
            }
            list.append(contentsOf: entitiesToAppend)
            
            referencesBlock.list = list
        }
    }
    
    private func updateQRCodes (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) {
        if let qrCodesBlock = cv.qrCodesBlock, change.isChangeEnabled {
            
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
            
            qrCodesBlock.qrCodes = items
        }
    }
    
    private func updateCoverLetter (cv: CVEntity, profile: ProfileEntity, language: Language, change: CVChange) async {
        if let generalBlock = cv.generalBlock, change.isChangeEnabled {
            if profile.jobTitle != generalBlock.jobTitle {
                if AiManager.getAiTextAttempts() > 0, change.descriptionGenerationEnabled {
                    let _ = await AIAssistant.applyAiActionCoverLetter(profile: profile, cv: cv, targetJob: cv.targetJob, targetCompany: cv.targetCompany, targetJobDescription: cv.targetJobDescription, language: language, action: 0, customAction: nil)
                }
            }
        }
    }
}

class CVChange {
    
    var blockId: Int
    var blockName, blockIcon: String
    var isChangeNeeded, isChangeEnabled: Bool
    var descriptionGenerationNeeded, descriptionGenerationEnabled: Bool
    var descriptionGenerationsCount: Int
    var descriptionGenerationsText: String
    
    init(blockId: Int, blockName: String, blockIcon: String, isChangeNeeded: Bool, isChangeEnabled: Bool, descriptionGenerationNeeded: Bool, descriptionGenerationEnabled: Bool, descriptionGenerationsCount: Int, descriptionGenerationsText: String) {
        self.blockId = blockId
        self.blockName = blockName
        self.blockIcon = blockIcon
        self.isChangeNeeded = isChangeNeeded
        self.isChangeEnabled = isChangeEnabled
        self.descriptionGenerationNeeded = descriptionGenerationNeeded
        self.descriptionGenerationEnabled = descriptionGenerationEnabled
        self.descriptionGenerationsCount = descriptionGenerationsCount
        self.descriptionGenerationsText = descriptionGenerationsText
    }
    
    static func getDefault () -> CVChange {
        return CVChange(blockId: 0, blockName: "General", blockIcon: "gear", isChangeNeeded: true, isChangeEnabled: true, descriptionGenerationNeeded: true, descriptionGenerationEnabled: true, descriptionGenerationsCount: 1, descriptionGenerationsText: "Generate description")
    }
}
