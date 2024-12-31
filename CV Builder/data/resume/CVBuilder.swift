//
//  CVBuilder.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class CVBuilder {
    
//    static func saveContext () {
//        DispatchQueue.main.async {
//            DatabaseBox.saveContext()
//        }
//    }
    
    func buildCv (profile: ProfileEntity, styleId: Int, langId: Int = -1, targetJob: String, targetInstitution: String, targetJobDescription: String, isFirst: Bool) async -> CVEntity {
        let language: Language
        if langId == -1 {
            language = TextLangDetector.getDefaultLanguage()
        } else {
            language = PreloadedDatabase.getLanguageById(id: langId)
        }
        
        let finalDescription = await AIAssistant.optimizeTargetJobDescription(targetJobDescription: targetJobDescription)
        
        if isFirst {
            let profileManager = ProfileManager()
            saveDefaultLanguageToProfile(profileManager: profileManager, profile: profile, language: language)
            await generateUserSkills(profileManager: profileManager, profile: profile, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: finalDescription, language: language.name)
        }
        
        let style = PreloadedDatabase.getStyleId(id: styleId)
        let palette = style.palettes[Int.random(in: 0..<style.palettes.count)]
        
        let generalBlock = await createGeneralBlock(profile: profile, page: 0, position: 0, isMainBlock: true, style: style) // fixed position according style
        
        let profileDescriptionBlock = await createProfileDescriptionBlock(profile: profile, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: finalDescription, language: language.name, page: 0, position: 0, isMainBlock: true, style: style)
        let contactBlock = await createContactBlock(profile: profile, page: 0, position: 1, isMainBlock: true, style: style)
        let educationBlock = await createEducationBlock(profile: profile, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: finalDescription, language: language.name, page: 0, position: 2, isMainBlock: true, style: style)
        let workBlock = await createWorkBlock(profile: profile, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: finalDescription, language: language.name, page: 0, position: 3, isMainBlock: true, style: style)
        
        let skillsBlock = await createSkillsBlock(profile: profile, page: 0, position: 4, isMainBlock: true, style: style)
        let languagesBlock = await createLanguagesBlock(profile: profile, page: 0, position: 5, isMainBlock: true, style: style)
        
        let interestsBlock = await createInterestsBlock(profile: profile, page: 0, position: 6, isMainBlock: true, style: style)
        
        let certificatesBlock = await createCertificatesBlock(profile: profile, page: 0, position: 7, isMainBlock: true, style: style)
        let referencesBlock = await createReferencesBlock(profile: profile, page: 0, position: 8, isMainBlock: true, style: style)
        
        let socialBlock = await createSocialMediaBlock(profile: profile, page: 0, position: 9, isMainBlock: true, style: style)
        let qrCodesBlock = await createQRCodesBlock(profile: profile, page: 0, position: 10, isMainBlock: true, style: style)
        
        var cvName = NSLocalizedString("resume", comment: "")
        if !profile.name.isEmpty {
            cvName = cvName + " - " + profile.name
        }
        
        let cv = CVEntity(generalBlock: generalBlock, profileDescBlock: profileDescriptionBlock, contactBlock: contactBlock, socialBlock: socialBlock, qrCodesBlock: qrCodesBlock, educationBlock: educationBlock, workBlock: workBlock, languagesBlock: languagesBlock, skillsBlock: skillsBlock, interestsBlock: interestsBlock, certificatesBlock: certificatesBlock, referencesBlock: referencesBlock, coverLetter: nil, name: cvName, lastModified: Date(), bookmarked: false, language: language.langId, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: finalDescription, previewOne: nil, previewTwo: nil, style: styleId, hasAdditionalBlock: style.hasAdditionalBlock, nameFont: style.fontName, headersFont: style.fontHeader, textFont: style.fontText, nameSize: style.sizeName, headersSize: style.sizeHeader, textSize: style.sizeText, marginsSize: style.margins, isHeadersBold: style.isHeaderBold, isHeadersUppercased: style.isHeaderUppercased, isHeadersItalic: style.isHeaderItalic, headerDotAdded: style.isHeaderDotAdded, headerLineAdded: style.isHeaderLineAdded, headerLinePosition: style.headerLinePosition, lineCirclesAdded: style.lineCirclesAdded, cornersRadius: style.cornersRadius, strokeWidth: style.strokeWidth, lineWidth: style.lineWidth, dotSize: style.dotSize, dotBackAdded: style.dotBackAdded, dotStrokeAdded: style.dotStrokeAdded, progressBarStyle: style.progressBarStyle, progressBarPercentAdded: style.progressBarPercentAdded, progressHeight: style.progressHeight, iconSize: style.iconSize, iconBackAdded: style.iconBackAdded, iconStrokeAdded: style.iconStrokeAdded, iconIsBold: style.iconIsBold, chipBackAdded: style.chipBackAdded, chipStrokeAdded: style.chipStrokeAdded, textResume: NSLocalizedString("resume", comment: ""), textCV: NSLocalizedString("cv", comment: ""), textProfile: NSLocalizedString("profile", comment: ""), textThankYou: NSLocalizedString("thank_you", comment: ""), mainColor: palette.mainColor, headerTextColor: palette.headerTextColor, mainTextColor: palette.mainTextColor, lineColor: palette.lineColor, lineCirclesColor: palette.lineCirclesColor, dotColor: palette.dotColor, dotStrokeColor: palette.dotStrokeColor, iconColor: palette.iconColor, iconBackgroundColor: palette.iconBackgroundColor, iconStrokeColor: palette.iconStrokeColor, qrForegroundColor: palette.qrForegroundColor, qrBackgroundColor: palette.qrBackgroundColor, progressForegroundColor: palette.progressForegroundColor, progressBackgroundColor: palette.progressBackgroundColor, chipTextColor: palette.chipTextColor, chipBackgroundColor: palette.chipBackgroundColor, chipStrokeColor: palette.chipStrokeColor)
        
        DatabaseBox.saveEntity(item: cv)
//        
//        saveContext()
//        let visualizationBuilder = CVVisualizationBuilder()
//        let visualizations = visualizationBuilder.createVisualizationsList(style: style, cv: cv)
        
        return cv
//        return visualizations
    }
    
    private func createGeneralBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> GeneralInfoBlockEntity {
        let block = GeneralInfoBlockEntity(name: profile.name, location: profile.location, jobTitle: profile.jobTitle, photoId: profile.photoId, isAdded: true, position: position, isMainBlock: isMainBlock, page: page, stylePhotoZoom: style.photoZoom, stylePhotoFilterEnabled: style.photoFilterEnabled, stylePhotoStrokeAdded: style.photoStrokeAdded)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createProfileDescriptionBlock (profile: ProfileEntity, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> ProfileDescriptionBlockEntity {
        let block = ProfileDescriptionBlockEntity(profileDescription: "", isAdded: true, position: position, isMainBlock: isMainBlock, page: page, textAboutMe: NSLocalizedString("about_me", comment: ""), styleHeaderAdded: style.profileDescHeaderAdded, styleHeaderPosition: style.profileDescHeaderPosition, styleQuotesAdded: style.profileDescQuotesAdded)
        if let text = await AIAssistant.generateProfileDescription(currentJob: profile.jobTitle, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: targetJobDescription, language: language) {
            block.profileDescription = text
        }
        block.isAdded = !block.profileDescription.isEmpty
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createContactBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> ContactInfoBlockEntity {
        let isBlockAdded = !profile.email.isEmpty || !profile.phone.isEmpty || !profile.websiteLink.isEmpty
        let block = ContactInfoBlockEntity(email: profile.email, phone: profile.phone, websiteLink: profile.websiteLink, websiteQrCodeId: profile.websiteQrCodeId, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, textContact: NSLocalizedString("contacts", comment: ""), textEmail: NSLocalizedString("email", comment: ""), textPhone: NSLocalizedString("phone_number", comment: ""), textWebsite: NSLocalizedString("website", comment: ""), styleIconAdded: style.contactIconAdded, styleHeaderAdded: style.contactHeaderAdded, styleHeaderPosition: style.contactHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createSocialMediaBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> SocialMediaBlockEntity {
        var items: [SocialMediaBlockItemEntity] = []
        if let list = profile.socialMediasList {
            for i in 0..<list.count {
                let media = list[i]
                let item = SocialMediaBlockItemEntity(entityId: media.id, link: media.link, media: media.media, qrCodeId: media.qrCodeId, isAdded: true, position: media.position, page: page)
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
        let isBlockAdded = items.count > 0
        let block = SocialMediaBlockEntity(list: items, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, styleIconAdded: style.socialIconAdded, styleHeaderPosition: style.socialHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createQRCodesBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> QRCodesBlockEntity {
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
        
        let isBlockAdded = items.count > 0
        let block = QRCodesBlockEntity(qrCodes: items, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, styleBackAdded: style.qrBackAdded)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createEducationBlock (profile: ProfileEntity, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> EducationBlockEntity {
        var items: [EducationBlockItemEntity] = []
        if let list = profile.educationsList {
            for i in 0..<list.count {
                let education = list[i]
                let item = EducationBlockItemEntity(entityId: education.id, desc: "", level: education.level, institution: education.institution, logoId: education.logoId, fieldOfStudy: education.fieldOfStudy, degree: education.degree, startDate: education.startDate, endDate: education.endDate, isStillLearning: education.isStillLearning, gpa: education.gpa, coursework: education.coursework, isAdded: true, position: education.position, page: page)
                if let text = await AIAssistant.generateEducationDescription(item: item, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: targetJobDescription, language: language, isBulletedList: style.educationDescritpionAsBulleted) {
                    item.desc = text
                }
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
//        let isBlockAdded = items.count > 0
        let block = EducationBlockEntity(list: items, isAdded: true, position: position, isMainBlock: isMainBlock, page: page, textEducation: NSLocalizedString("education", comment: ""), styleDateWithHeader: style.educationDateWithHeader, styleDateAfterHeader: style.educationDateAfterHeader, styleDateSeparated: style.educationDateSeparated, styleDateInBrackets: style.educationDateInBrackets, styleMonthDisplayed: style.educationMonthDisplayed, styleDotsAdded: style.educationDotsAdded, styleDescritpionAsBulleted: style.educationDescritpionAsBulleted, styleHeaderPosition: style.educationHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createWorkBlock (profile: ProfileEntity, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> WorkBlockEntity {
        var items: [WorkBlockItemEntity] = []
        if let list = profile.worksList {
            for i in 0..<list.count {
                let work = list[i]
                let item = WorkBlockItemEntity(entityId: work.id, desc: "", jobTitle: work.jobTitle, company: work.company, iconId: work.iconId, location: work.location, startDate: work.startDate, endDate: work.endDate, isStillWorking: work.isStillWorking, responsibilities: work.responsibilities, remote: work.remote, partTime: work.partTime, isAdded: true, position: work.position, page: page)
                if let text = await AIAssistant.generateWorkDescription(item: item, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: targetJobDescription, language: language, isBulletedList: style.workDescritpionAsBulleted) {
                    item.desc = text
                }
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
//        let isBlockAdded = items.count > 0
        let block = WorkBlockEntity(list: items, isAdded: true, position: position, isMainBlock: isMainBlock, page: page, textWorkExperience: NSLocalizedString("work_experience", comment: ""), styleDateWithHeader: style.workDateWithHeader, styleDateAfterHeader: style.workDateAfterHeader, styleDateSeparated: style.workDateSeparated, styleDateInBrackets: style.workDateInBrackets, styleMonthDisplayed: style.workMonthDisplayed, styleDotsAdded: style.workDotsAdded, styleDescritpionAsBulleted: style.workDescritpionAsBulleted, styleHeaderPosition: style.workHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createLanguagesBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> LanguagesBlockEntity {
        var items: [LanguageBlockItemEntity] = []
        if let list = profile.languagesList {
            for i in 0..<list.count {
                let lang = list[i]
                let item = LanguageBlockItemEntity(entityId: lang.id, langId: lang.langId, name: lang.name, level: lang.level, isAdded: true, position: lang.position, page: page)
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
        let isBlockAdded = items.count > 0
        let block = LanguagesBlockEntity(list: items, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, textLanguages: NSLocalizedString("languages", comment: ""), styleIsBulletedList: style.languagesIsBulletedList, styleIsProgressAdded: style.languagesIsProgressAdded, styleIsLevelAdded: style.languagesIsLevelAdded, styleIconAdded: style.languagesIconAdded, styleHeaderPosition: style.languagesHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createInterestsBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> InterestsBlockEntity {
        var items: [InterestBlockItemEntity] = []
        if let list = profile.interestsList {
            for i in 0..<list.count {
                let interest = list[i]
                let item = InterestBlockItemEntity(entityId: interest.id, name: interest.name, isAdded: true, position: interest.position)
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
        let isBlockAdded = items.count > 0
        let block = InterestsBlockEntity(list: items, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, textInterests: NSLocalizedString("interests", comment: ""), styleIsBulletedList: style.interestsIsBulletedList, styleIsChips: style.interestsIsChips, styleHeaderPosition: style.interestsHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createSkillsBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> SkillsBlockEntity {
        var items: [SkillBlockItemEntity] = []
        if let list = profile.skillsList {
            for i in 0..<list.count {
                let skill = list[i]
                let item = SkillBlockItemEntity(entityId: skill.id, name: skill.name, level: skill.level, iconId: skill.iconId, category: skill.category, isAdded: true, position: skill.position)
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
        let isBlockAdded = items.count > 0
        let block = SkillsBlockEntity(list: items, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, textSkills: NSLocalizedString("skills", comment: ""), styleIsBulletedList: style.skillsIsBulletedList, styleIsChips: style.skillsIsChips, styleIsProgressAdded: style.skillsIsProgressAdded, styleHeaderPosition: style.skillsHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createCertificatesBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> CertificatesBlockEntity {
        var items: [CertificateBlockItemEntity] = []
        if let list = profile.certificatesList {
            for i in 0..<list.count {
                let certificate = list[i]
                let item = CertificateBlockItemEntity(entityId: certificate.id, name: certificate.name, isAdded: true, position: certificate.position)
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
        let isBlockAdded = items.count > 0
        let block = CertificatesBlockEntity(list: items, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, textCertificates: NSLocalizedString("certificates", comment: ""), styleIsBulletedList: style.certificatesIsBulletedList, styleHeaderPosition: style.certificatesHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func createReferencesBlock (profile: ProfileEntity, page: Int = 0, position: Int, isMainBlock: Bool, style: Style) async -> ReferencesBlockEntity {
        var items: [ReferenceBlockItemEntity] = []
        if let list = profile.referencesList {
            for i in 0..<list.count {
                let reference = list[i]
                let item = ReferenceBlockItemEntity(entityId: reference.id, referralName: reference.referralName, company: reference.company, email: reference.email, phone: reference.phone, isAdded: true, position: reference.position)
//                DatabaseBox.saveEntity(item: item)
                items.append(item)
            }
        }
        let isBlockAdded = items.count > 0
        let block = ReferencesBlockEntity(list: items, isAdded: isBlockAdded, position: position, isMainBlock: isMainBlock, page: page, textReferences: NSLocalizedString("references", comment: ""), styleIsBulletedList: style.referencesIsBulletedList, styleHeaderPosition: style.referencesHeaderPosition)
//        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func saveDefaultLanguageToProfile (profileManager: ProfileManager, profile: ProfileEntity, language: Language) {
        if let list = profile.languagesList, list.count == 0 {
            profileManager.saveLanguage(profile: profile, langId: language.langId, name: language.name, level: 4)
        }
    }
    
    private func generateUserSkills (profileManager: ProfileManager, profile: ProfileEntity, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String) async {
        if let list = profile.skillsList, list.count == 0 {
            let skillsList = await AIAssistant.generateUserSkills(currentJob: profile.jobTitle, targetJob: targetJob, targetJobDescription: targetJobDescription, language: language)
            if skillsList.count > 0 {
                for skill in skillsList {
                    let _ = profileManager.saveSkill(profile: profile, name: skill, level: Int.random(in: 4..<6))
                }
            }
        }
    }
    
    func saveCoverLetter (cv: CVEntity, text: String) {
        if !text.isEmpty {
            let style = PreloadedDatabase.getStyleId(id: cv.style)
            let coverLetter = CoverLetterEntity(text: text, textCoverLetter: NSLocalizedString("cover_letter", comment: ""), textSize: style.sizeCover)
            DatabaseBox.saveEntity(item: coverLetter)
            
            cv.coverLetter = coverLetter
            
            DatabaseBox.saveContext()
        }
    }
    
    func updateCoverLetter (cover: CoverLetterEntity, text: String) {
        if !text.isEmpty {
            cover.text = text
            DatabaseBox.saveContext()
        }
    }
    
    func saveWrapperPagesToEntity (wrapper: CVEntityWrapper, cv: CVEntity) -> CVEntity {
        if let profileDescBlock = wrapper.profileDescBlock, let profileDescBlockCv = cv.profileDescBlock {
            profileDescBlockCv.page = profileDescBlock.page
            profileDescBlockCv.isMainBlock = profileDescBlock.isMainBlock
            profileDescBlockCv.isAdded = profileDescBlock.isAdded
            profileDescBlockCv.position = profileDescBlock.position
            cv.profileDescBlock = profileDescBlockCv
        }
        if let contactBlock = wrapper.contactBlock, let contactBlockCv = cv.contactBlock {
            contactBlockCv.page = contactBlock.page
            contactBlockCv.isMainBlock = contactBlock.isMainBlock
            contactBlockCv.isAdded = contactBlock.isAdded
            contactBlockCv.position = contactBlock.position
            cv.contactBlock = contactBlockCv
        }
        if let educationBlock = wrapper.educationBlock, let educationBlockCv = cv.educationBlock {
            educationBlockCv.page = educationBlock.page
            educationBlockCv.isMainBlock = educationBlock.isMainBlock
            educationBlockCv.isAdded = educationBlock.isAdded
            educationBlockCv.position = educationBlock.position
            cv.educationBlock = educationBlockCv
        }
        if let workBlock = wrapper.workBlock, let workBlockCv = cv.workBlock {
            workBlockCv.page = workBlock.page
            workBlockCv.isMainBlock = workBlock.isMainBlock
            workBlockCv.isAdded = workBlock.isAdded
            workBlockCv.position = workBlock.position
            cv.workBlock = workBlockCv
        }
        if let skillsBlock = wrapper.skillsBlock, let skillsBlockCv = cv.skillsBlock {
            skillsBlockCv.page = skillsBlock.page
            skillsBlockCv.isMainBlock = skillsBlock.isMainBlock
            skillsBlockCv.isAdded = skillsBlock.isAdded
            skillsBlockCv.position = skillsBlock.position
            cv.skillsBlock = skillsBlockCv
        }
        if let languagesBlock = wrapper.languagesBlock, let languagesBlockCv = cv.languagesBlock {
            languagesBlockCv.page = languagesBlock.page
            languagesBlockCv.isMainBlock = languagesBlock.isMainBlock
            languagesBlockCv.isAdded = languagesBlock.isAdded
            languagesBlockCv.position = languagesBlock.position
            cv.languagesBlock = languagesBlockCv
        }
        if let interestsBlock = wrapper.interestsBlock, let interestsBlockCv = cv.interestsBlock {
            interestsBlockCv.page = interestsBlock.page
            interestsBlockCv.isMainBlock = interestsBlock.isMainBlock
            interestsBlockCv.isAdded = interestsBlock.isAdded
            interestsBlockCv.position = interestsBlock.position
            cv.interestsBlock = interestsBlockCv
        }
        if let certificatesBlock = wrapper.certificatesBlock, let certificatesBlockCv = cv.certificatesBlock {
            certificatesBlockCv.page = certificatesBlock.page
            certificatesBlockCv.isMainBlock = certificatesBlock.isMainBlock
            certificatesBlockCv.isAdded = certificatesBlock.isAdded
            certificatesBlockCv.position = certificatesBlock.position
            cv.certificatesBlock = certificatesBlockCv
        }
        if let referencesBlock = wrapper.referencesBlock, let referencesBlockCv = cv.referencesBlock {
            referencesBlockCv.page = referencesBlock.page
            referencesBlockCv.isMainBlock = referencesBlock.isMainBlock
            referencesBlockCv.isAdded = referencesBlock.isAdded
            referencesBlockCv.position = referencesBlock.position
            cv.referencesBlock = referencesBlockCv
        }
        if let socialBlock = wrapper.socialBlock, let socialBlockCv = cv.socialBlock {
            socialBlockCv.page = socialBlock.page
            socialBlockCv.isMainBlock = socialBlock.isMainBlock
            socialBlockCv.isAdded = socialBlock.isAdded
            socialBlockCv.position = socialBlock.position
            cv.socialBlock = socialBlockCv
        }
        if let qrCodesBlock = wrapper.qrCodesBlock, let qrCodesBlockCv = cv.qrCodesBlock {
            qrCodesBlockCv.page = qrCodesBlock.page
            qrCodesBlockCv.isMainBlock = qrCodesBlock.isMainBlock
            qrCodesBlockCv.isAdded = qrCodesBlock.isAdded
            qrCodesBlockCv.position = qrCodesBlock.position
            cv.qrCodesBlock = qrCodesBlockCv
        }
        DatabaseBox.saveContext()
        return cv
    }
    
    func updateCvStyle (cv: CVEntity, style: Style) {
        cv.style = style.id
        cv.hasAdditionalBlock = style.hasAdditionalBlock
        
        let palette = style.palettes[Int.random(in: 0..<style.palettes.count)]
        updateCvPalette(cv: cv, palette: palette)
        
        cv.nameFont = style.fontName
        cv.headersFont = style.fontHeader
        cv.textFont = style.fontText
        cv.nameSize = style.sizeName
        cv.headersSize = style.sizeHeader
        cv.textSize = style.sizeText
        
        cv.marginsSize = style.margins
        
        cv.isHeadersBold = style.isHeaderBold
        cv.isHeadersUppercased = style.isHeaderUppercased
        cv.isHeadersItalic = style.isHeaderItalic
        cv.headerDotAdded = style.isHeaderDotAdded
        cv.headerLineAdded = style.isHeaderLineAdded
        cv.headerLinePosition = style.headerLinePosition
        cv.lineCirclesAdded = style.lineCirclesAdded
        
        cv.cornersRadius = style.cornersRadius
        
        cv.strokeWidth = style.strokeWidth
        cv.lineWidth = style.lineWidth
        
        cv.dotSize = style.dotSize
        cv.dotBackAdded = style.dotBackAdded
        cv.dotStrokeAdded = style.dotStrokeAdded
        
        cv.progressBarStyle = style.progressBarStyle
        cv.progressBarPercentAdded = style.progressBarPercentAdded
        cv.progressHeight = style.progressHeight
        
        cv.iconSize = style.iconSize
        cv.iconBackAdded = style.iconBackAdded
        cv.iconStrokeAdded = style.iconStrokeAdded
        cv.iconIsBold = style.iconIsBold
        
        cv.chipBackAdded = style.chipBackAdded
        cv.chipStrokeAdded = style.chipStrokeAdded
        
        if let coverLetter = cv.coverLetter {
            coverLetter.textSize = style.sizeCover
        }
        
        if let block = cv.generalBlock {
            block.stylePhotoZoom = style.photoZoom
            block.stylePhotoStrokeAdded = style.photoStrokeAdded
            block.stylePhotoFilterEnabled = style.photoFilterEnabled
        }
        
        if let block = cv.profileDescBlock {
            block.styleHeaderAdded = style.profileDescHeaderAdded
            block.styleHeaderPosition = style.profileDescHeaderPosition
            block.styleQuotesAdded = style.profileDescQuotesAdded
        }
        
        if let block = cv.contactBlock {
            block.styleIconAdded = style.contactIconAdded
            block.styleHeaderAdded = style.contactHeaderAdded
            block.styleHeaderPosition = style.contactHeaderPosition
        }
        
        if let block = cv.socialBlock {
            block.styleIconAdded = style.socialIconAdded
            block.styleHeaderPosition = style.socialHeaderPosition
        }
        
        if let block = cv.qrCodesBlock {
            block.styleBackAdded = style.qrBackAdded
        }
        
        if let block = cv.educationBlock {
            block.styleDateWithHeader = style.educationDateWithHeader
            block.styleDateAfterHeader = style.educationDateAfterHeader
            block.styleDateSeparated = style.educationDateSeparated
            block.styleDateInBrackets = style.educationDateInBrackets
            block.styleMonthDisplayed = style.educationMonthDisplayed
            block.styleDotsAdded = style.educationDotsAdded
            block.styleDescritpionAsBulleted = style.educationDescritpionAsBulleted
            block.styleHeaderPosition = style.educationHeaderPosition
        }
        
        if let block = cv.workBlock {
            block.styleDateWithHeader = style.workDateWithHeader
            block.styleDateAfterHeader = style.workDateAfterHeader
            block.styleDateSeparated = style.workDateSeparated
            block.styleDateInBrackets = style.workDateInBrackets
            block.styleMonthDisplayed = style.workMonthDisplayed
            block.styleDotsAdded = style.workDotsAdded
            block.styleDescritpionAsBulleted = style.workDescritpionAsBulleted
            block.styleHeaderPosition = style.workHeaderPosition
        }
        
        if let block = cv.languagesBlock {
            block.styleIsBulletedList = style.languagesIsBulletedList
            block.styleIsProgressAdded = style.languagesIsProgressAdded
            block.styleIsLevelAdded = style.languagesIsLevelAdded
            block.styleIconAdded = style.languagesIconAdded
            block.styleHeaderPosition = style.languagesHeaderPosition
        }
        
        if let block = cv.skillsBlock {
            block.styleIsBulletedList = style.skillsIsBulletedList
            block.styleIsChips = style.skillsIsChips
            block.styleIsProgressAdded = style.skillsIsProgressAdded
            block.styleHeaderPosition = style.skillsHeaderPosition
        }
        
        if let block = cv.interestsBlock {
            block.styleIsBulletedList = style.interestsIsBulletedList
            block.styleIsChips = style.interestsIsChips
            block.styleHeaderPosition = style.interestsHeaderPosition
        }
        
        if let block = cv.certificatesBlock {
            block.styleIsBulletedList = style.certificatesIsBulletedList
            block.styleHeaderPosition = style.certificatesHeaderPosition
        }
        
        if let block = cv.referencesBlock {
            block.styleIsBulletedList = style.referencesIsBulletedList
            block.styleHeaderPosition = style.referencesHeaderPosition
        }
    }
    
    func updateCvPalette (cv: CVEntity, palette: Palette) {
        cv.mainColor = palette.mainColor
        cv.headerTextColor = palette.headerTextColor
        cv.mainTextColor = palette.mainTextColor
        cv.iconColor = palette.iconColor
        cv.iconBackgroundColor = palette.iconBackgroundColor
        cv.iconStrokeColor = palette.iconStrokeColor
        cv.lineColor = palette.lineColor
        cv.lineCirclesColor = palette.lineCirclesColor
        cv.dotColor = palette.dotColor
        cv.dotStrokeColor = palette.dotStrokeColor
        cv.qrForegroundColor = palette.qrForegroundColor
        cv.qrBackgroundColor = palette.qrBackgroundColor
        cv.progressForegroundColor = palette.progressForegroundColor
        cv.progressBackgroundColor = palette.progressBackgroundColor
        cv.chipTextColor = palette.chipTextColor
        cv.chipBackgroundColor = palette.chipBackgroundColor
        cv.chipStrokeColor = palette.chipStrokeColor
    }
    
    func duplicateCv (cv: CVEntity) -> CVEntity {
        let newCv = CVEntity(entity: cv)
        
        if let generalBlock = cv.generalBlock {
            newCv.generalBlock = duplicateGeneralInfoBlock(base: generalBlock)
        }
        
        if let profileDescBlock = cv.profileDescBlock {
            newCv.profileDescBlock = duplicateProfileDescBlock(base: profileDescBlock)
        }
        
        if let contactBlock = cv.contactBlock {
            newCv.contactBlock = duplicateContactBlock(base: contactBlock)
        }
        
        if let socialBlock = cv.socialBlock {
            newCv.socialBlock = duplicateSocialMediaBlock(base: socialBlock)
        }
        
        if let qrCodesBlock = cv.qrCodesBlock {
            newCv.qrCodesBlock = duplicateQrCodesBlock(base: qrCodesBlock)
        }
        
        if let educationBlock = cv.educationBlock {
            newCv.educationBlock = duplicateEducationBlock(base: educationBlock)
        }
        
        if let workBlock = cv.workBlock {
            newCv.workBlock = duplicateWorkBlock(base: workBlock)
        }
        
        if let skillsBlock = cv.skillsBlock {
            newCv.skillsBlock = duplicateSkillsBlock(base: skillsBlock)
        }
        
        if let languagesBlock = cv.languagesBlock {
            newCv.languagesBlock = duplicateLanguagesBlock(base: languagesBlock)
        }
        
        if let interestsBlock = cv.interestsBlock {
            newCv.interestsBlock = duplicateInterestsBlock(base: interestsBlock)
        }
        
        if let certificatesBlock = cv.certificatesBlock {
            newCv.certificatesBlock = duplicateCertificatesBlock(base: certificatesBlock)
        }
        
        if let referencesBlock = cv.referencesBlock {
            newCv.referencesBlock = duplicateReferencesBlock(base: referencesBlock)
        }
        
        if let coverLetter = cv.coverLetter {
            newCv.coverLetter = duplicateCoverLetter(base: coverLetter)
        }
        
        DatabaseBox.saveEntity(item: newCv)
        
        return newCv
    }
    
    private func duplicateCoverLetter (base: CoverLetterEntity) -> CoverLetterEntity {
        let letter = CoverLetterEntity(entity: base)
        DatabaseBox.saveEntity(item: letter)
        return letter
    }
    
    private func duplicateGeneralInfoBlock (base: GeneralInfoBlockEntity) -> GeneralInfoBlockEntity {
        let block = GeneralInfoBlockEntity(entity: base)
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateProfileDescBlock (base: ProfileDescriptionBlockEntity) -> ProfileDescriptionBlockEntity {
        let block = ProfileDescriptionBlockEntity(entity: base)
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateContactBlock (base: ContactInfoBlockEntity) -> ContactInfoBlockEntity {
        let block = ContactInfoBlockEntity(entity: base)
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateSocialMediaBlock (base: SocialMediaBlockEntity) -> SocialMediaBlockEntity {
        let block = SocialMediaBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [SocialMediaBlockItemEntity] = []
            for item in list {
                let i = SocialMediaBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateQrCodesBlock (base: QRCodesBlockEntity) -> QRCodesBlockEntity {
        let block = QRCodesBlockEntity(entity: base)
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateEducationBlock (base: EducationBlockEntity) -> EducationBlockEntity {
        let block = EducationBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [EducationBlockItemEntity] = []
            for item in list {
                let i = EducationBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateWorkBlock (base: WorkBlockEntity) -> WorkBlockEntity {
        let block = WorkBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [WorkBlockItemEntity] = []
            for item in list {
                let i = WorkBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateLanguagesBlock (base: LanguagesBlockEntity) -> LanguagesBlockEntity {
        let block = LanguagesBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [LanguageBlockItemEntity] = []
            for item in list {
                let i = LanguageBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateSkillsBlock (base: SkillsBlockEntity) -> SkillsBlockEntity {
        let block = SkillsBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [SkillBlockItemEntity] = []
            for item in list {
                let i = SkillBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateInterestsBlock (base: InterestsBlockEntity) -> InterestsBlockEntity {
        let block = InterestsBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [InterestBlockItemEntity] = []
            for item in list {
                let i = InterestBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateCertificatesBlock (base: CertificatesBlockEntity) -> CertificatesBlockEntity {
        let block = CertificatesBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [CertificateBlockItemEntity] = []
            for item in list {
                let i = CertificateBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    private func duplicateReferencesBlock (base: ReferencesBlockEntity) -> ReferencesBlockEntity {
        let block = ReferencesBlockEntity(entity: base)
        
        if let list = base.list {
            var newList: [ReferenceBlockItemEntity] = []
            for item in list {
                let i = ReferenceBlockItemEntity(entity: item)
                DatabaseBox.saveEntity(item: i)
                newList.append(i)
            }
            block.list = newList
        }
        
        DatabaseBox.saveEntity(item: block)
        return block
    }
    
    
    
    // Delete
    
    func deleteCv (cv: CVEntity) {
        let generalBlock = cv.generalBlock
        cv.generalBlock = nil
        if let generalBlock {
            DatabaseBox.deleteEntity(item: generalBlock)
        }
        
        let profileDescBlock = cv.profileDescBlock
        cv.profileDescBlock = nil
        if let profileDescBlock {
            DatabaseBox.deleteEntity(item: profileDescBlock)
        }
        
        let contactBlock = cv.contactBlock
        cv.contactBlock = nil
        if let contactBlock {
            DatabaseBox.deleteEntity(item: contactBlock)
        }
        
        let socialBlock = cv.socialBlock
        cv.socialBlock = nil
        if let socialBlock {
            deleteSocialMediaBlock(item: socialBlock)
        }
        
        let qrCodesBlock = cv.qrCodesBlock
        cv.qrCodesBlock = nil
        if let qrCodesBlock {
            DatabaseBox.deleteEntity(item: qrCodesBlock)
        }
        
        let educationBlock = cv.educationBlock
        cv.educationBlock = nil
        if let educationBlock {
            deleteEducationBlock(item: educationBlock)
        }
        
        let workBlock = cv.workBlock
        cv.workBlock = nil
        if let workBlock {
            deleteWorkBlock(item: workBlock)
        }
        
        let languagesBlock = cv.languagesBlock
        cv.languagesBlock = nil
        if let languagesBlock {
            deleteLanguagesBlock(item: languagesBlock)
        }
        
        let skillsBlock = cv.skillsBlock
        cv.skillsBlock = nil
        if let skillsBlock {
            deleteSkillsBlock(item: skillsBlock)
        }
        
        let interestsBlock = cv.interestsBlock
        cv.interestsBlock = nil
        if let interestsBlock {
            deleteInterestsBlock(item: interestsBlock)
        }
        
        let certificatesBlock = cv.certificatesBlock
        cv.certificatesBlock = nil
        if let certificatesBlock {
            deleteCertificatesBlock(item: certificatesBlock)
        }
        
        let referencesBlock = cv.referencesBlock
        cv.referencesBlock = nil
        if let referencesBlock {
            deleteReferencesBlock(item: referencesBlock)
        }
        
        DatabaseBox.deleteEntity(item: cv)
    }
    
    private func deleteSocialMediaBlock (item: SocialMediaBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
    
    private func deleteEducationBlock (item: EducationBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
    
    private func deleteWorkBlock (item: WorkBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
    
    private func deleteLanguagesBlock (item: LanguagesBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
    
    private func deleteSkillsBlock (item: SkillsBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
    
    private func deleteInterestsBlock (item: InterestsBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
    
    private func deleteCertificatesBlock (item: CertificatesBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
    
    private func deleteReferencesBlock (item: ReferencesBlockEntity) {
        let items = item.list
        item.list = []
        if let items {
            for i in items {
                DatabaseBox.deleteEntity(item: i)
            }
        }
        DatabaseBox.deleteEntity(item: item)
    }
}
