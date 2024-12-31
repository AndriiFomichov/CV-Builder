//
//  CVEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class CVEntityWrapper: Hashable {
    
    var id: Int
    
    var entity: CVEntity?
    
    var wrapperName: String = ""
    
    var generalBlock: GeneralInfoBlockEntityWrapper?
    var profileDescBlock: ProfileDescriptionBlockEntityWrapper?
    var contactBlock: ContactInfoBlockEntityWrapper?
    var socialBlock: SocialMediaBlockEntityWrapper?
    var qrCodesBlock: QRCodesBlockEntityWrapper?
    var educationBlock: EducationBlockEntityWrapper?
    var workBlock: WorkBlockEntityWrapper?
    var languagesBlock: LanguagesBlockEntityWrapper?
    var skillsBlock: SkillsBlockEntityWrapper?
    var interestsBlock: InterestsBlockEntityWrapper?
    var certificatesBlock: CertificatesBlockEntityWrapper?
    var referencesBlock: ReferencesBlockEntityWrapper?
    
    var coverLetter: CoverLetterEntityWrapper?

    var style: Int
    var hasAdditionalBlock: Bool
    
    var nameFont: Int
    var headersFont: Int
    var textFont: Int
    
    var nameSize: Int
    var headersSize: Int
    var textSize: Int
    
    var marginsSize: Int
    
    var isHeadersBold: Bool
    var isHeadersUppercased: Bool
    var isHeadersItalic: Bool
    
    var headerDotAdded: Bool
    var headerLineAdded: Bool
    var headerLinePosition: Int
    
    var lineCirclesAdded: Bool
    
    var cornersRadius: Int
    
    var strokeWidth: Int
    var lineWidth: Int
    
    var dotSize: Int
    var dotBackAdded: Bool
    var dotStrokeAdded: Bool
    
    var progressBarStyle: Int
    var progressBarPercentAdded: Bool
    var progressHeight: Int
    
    var iconSize: Int
    var iconBackAdded: Bool
    var iconStrokeAdded: Bool
    var iconIsBold: Bool
    
    var chipBackAdded: Bool
    var chipStrokeAdded: Bool

    var textResume: String
    var textCV: String
    var textProfile: String
    var textThankYou: String
    
    var mainColor: String
    var headerTextColor: String
    var mainTextColor: String
    var iconColor: String
    var iconBackgroundColor: String
    var iconStrokeColor: String
    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    var qrForegroundColor: String
    var qrBackgroundColor: String
    var progressForegroundColor: String
    var progressBackgroundColor: String
    var chipTextColor: String
    var chipBackgroundColor: String
    var chipStrokeColor: String
    
    init(entity: CVEntity?, id: Int, wrapperName: String = "", generalBlock: GeneralInfoBlockEntityWrapper?, profileDescBlock: ProfileDescriptionBlockEntityWrapper?, contactBlock: ContactInfoBlockEntityWrapper?, socialBlock: SocialMediaBlockEntityWrapper?, qrCodesBlock: QRCodesBlockEntityWrapper?, educationBlock: EducationBlockEntityWrapper?, workBlock: WorkBlockEntityWrapper?, languagesBlock: LanguagesBlockEntityWrapper?, skillsBlock: SkillsBlockEntityWrapper?, interestsBlock: InterestsBlockEntityWrapper?, certificatesBlock: CertificatesBlockEntityWrapper?, referencesBlock: ReferencesBlockEntityWrapper?, coverLetter: CoverLetterEntityWrapper?, style: Int, hasAdditionalBlock: Bool, nameFont: Int, headersFont: Int, textFont: Int, nameSize: Int, headersSize: Int, textSize: Int, marginsSize: Int, isHeadersBold: Bool, isHeadersUppercased: Bool, isHeadersItalic: Bool, headerDotAdded: Bool, headerLineAdded: Bool, headerLinePosition: Int, lineCirclesAdded: Bool, cornersRadius: Int, strokeWidth: Int, lineWidth: Int, dotSize: Int, dotBackAdded: Bool, dotStrokeAdded: Bool, progressBarStyle: Int, progressBarPercentAdded: Bool, progressHeight: Int, iconSize: Int, iconBackAdded: Bool, iconStrokeAdded: Bool, iconIsBold: Bool, chipBackAdded: Bool, chipStrokeAdded: Bool, textResume: String, textCV: String, textProfile: String, textThankYou: String, mainColor: String, headerTextColor: String, mainTextColor: String, lineColor: String, lineCirclesColor: String, dotColor: String, dotStrokeColor: String, iconColor: String, iconBackgroundColor: String, iconStrokeColor: String, qrForegroundColor: String, qrBackgroundColor: String, progressForegroundColor: String, progressBackgroundColor: String, chipTextColor: String, chipBackgroundColor: String, chipStrokeColor: String) {
        self.entity = entity
        self.id = id
        self.wrapperName = wrapperName
        self.generalBlock = generalBlock
        self.profileDescBlock = profileDescBlock
        self.contactBlock = contactBlock
        self.socialBlock = socialBlock
        self.qrCodesBlock = qrCodesBlock
        self.educationBlock = educationBlock
        self.workBlock = workBlock
        self.languagesBlock = languagesBlock
        self.skillsBlock = skillsBlock
        self.interestsBlock = interestsBlock
        self.certificatesBlock = certificatesBlock
        self.referencesBlock = referencesBlock
        self.coverLetter = coverLetter
        self.style = style
        self.hasAdditionalBlock = hasAdditionalBlock
        self.nameFont = nameFont
        self.headersFont = headersFont
        self.textFont = textFont
        self.nameSize = nameSize
        self.headersSize = headersSize
        self.textSize = textSize
        self.marginsSize = marginsSize
        self.isHeadersBold = isHeadersBold
        self.isHeadersUppercased = isHeadersUppercased
        self.isHeadersItalic = isHeadersItalic
        self.headerDotAdded = headerDotAdded
        self.headerLineAdded = headerLineAdded
        self.headerLinePosition = headerLinePosition
        self.lineCirclesAdded = lineCirclesAdded
        self.cornersRadius = cornersRadius
        self.strokeWidth = strokeWidth
        self.lineWidth = lineWidth
        self.dotSize = dotSize
        self.dotBackAdded = dotBackAdded
        self.dotStrokeAdded = dotStrokeAdded
        self.progressBarStyle = progressBarStyle
        self.progressBarPercentAdded = progressBarPercentAdded
        self.progressHeight = progressHeight
        self.iconSize = iconSize
        self.iconBackAdded = iconBackAdded
        self.iconStrokeAdded = iconStrokeAdded
        self.iconIsBold = iconIsBold
        self.chipBackAdded = chipBackAdded
        self.chipStrokeAdded = chipStrokeAdded
        self.textResume = textResume
        self.textCV = textCV
        self.textProfile = textProfile
        self.textThankYou = textThankYou
        self.mainColor = mainColor
        self.headerTextColor = headerTextColor
        self.mainTextColor = mainTextColor
        self.iconColor = iconColor
        self.iconBackgroundColor = iconBackgroundColor
        self.iconStrokeColor = iconStrokeColor
        self.lineColor = lineColor
        self.lineCirclesColor = lineCirclesColor
        self.dotColor = dotColor
        self.dotStrokeColor = dotStrokeColor
        self.qrForegroundColor = qrForegroundColor
        self.qrBackgroundColor = qrBackgroundColor
        self.progressForegroundColor = progressForegroundColor
        self.progressBackgroundColor = progressBackgroundColor
        self.chipTextColor = chipTextColor
        self.chipBackgroundColor = chipBackgroundColor
        self.chipStrokeColor = chipStrokeColor
    }
    
    init(entity: CVEntity) {
        self.id = -1
        self.entity = entity
        
        if let generalBlock = entity.generalBlock {
            self.generalBlock = GeneralInfoBlockEntityWrapper(entity: generalBlock)
        }
        if let profileDescBlock = entity.profileDescBlock {
            self.profileDescBlock = ProfileDescriptionBlockEntityWrapper(entity: profileDescBlock)
        }
        if let contactBlock = entity.contactBlock {
            self.contactBlock = ContactInfoBlockEntityWrapper(entity: contactBlock)
        }
        if let socialBlock = entity.socialBlock {
            self.socialBlock = SocialMediaBlockEntityWrapper(entity: socialBlock)
        }
        if let qrCodesBlock = entity.qrCodesBlock {
            self.qrCodesBlock = QRCodesBlockEntityWrapper(entity: qrCodesBlock)
        }
        if let educationBlock = entity.educationBlock {
            self.educationBlock = EducationBlockEntityWrapper(entity: educationBlock)
        }
        if let workBlock = entity.workBlock {
            self.workBlock = WorkBlockEntityWrapper(entity: workBlock)
        }
        if let languagesBlock = entity.languagesBlock {
            self.languagesBlock = LanguagesBlockEntityWrapper(entity: languagesBlock)
        }
        if let skillsBlock = entity.skillsBlock {
            self.skillsBlock = SkillsBlockEntityWrapper(entity: skillsBlock)
        }
        if let interestsBlock = entity.interestsBlock {
            self.interestsBlock = InterestsBlockEntityWrapper(entity: interestsBlock)
        }
        if let certificatesBlock = entity.certificatesBlock {
            self.certificatesBlock = CertificatesBlockEntityWrapper(entity: certificatesBlock)
        }
        if let referencesBlock = entity.referencesBlock {
            self.referencesBlock = ReferencesBlockEntityWrapper(entity: referencesBlock)
        }
        
        if let coverLetter = entity.coverLetter {
            self.coverLetter = CoverLetterEntityWrapper(entity: coverLetter)
        }
        
        self.style = entity.style
        self.hasAdditionalBlock = entity.hasAdditionalBlock
        self.nameFont = entity.nameFont
        self.headersFont = entity.headersFont
        self.textFont = entity.textFont
        self.nameSize = entity.nameSize
        self.headersSize = entity.headersSize
        self.textSize = entity.textSize
        self.marginsSize = entity.marginsSize
        self.isHeadersBold = entity.isHeadersBold
        self.isHeadersUppercased = entity.isHeadersUppercased
        self.isHeadersItalic = entity.isHeadersItalic
        self.headerDotAdded = entity.headerDotAdded
        self.headerLineAdded = entity.headerLineAdded
        self.headerLinePosition = entity.headerLinePosition
        self.lineCirclesAdded = entity.lineCirclesAdded
        self.cornersRadius = entity.cornersRadius
        self.strokeWidth = entity.strokeWidth
        self.lineWidth = entity.lineWidth
        self.dotSize = entity.dotSize
        self.dotBackAdded = entity.dotBackAdded
        self.dotStrokeAdded = entity.dotStrokeAdded
        self.progressBarStyle = entity.progressBarStyle
        self.progressBarPercentAdded = entity.progressBarPercentAdded
        self.progressHeight = entity.progressHeight
        self.iconSize = entity.iconSize
        self.iconBackAdded = entity.iconBackAdded
        self.iconStrokeAdded = entity.iconStrokeAdded
        self.iconIsBold = entity.iconIsBold
        self.chipBackAdded = entity.chipBackAdded
        self.chipStrokeAdded = entity.chipStrokeAdded
        self.textResume = entity.textResume
        self.textCV = entity.textCV
        self.textProfile = entity.textProfile
        self.textThankYou = entity.textThankYou
        self.mainColor = entity.mainColor
        self.headerTextColor = entity.headerTextColor
        self.mainTextColor = entity.mainTextColor
        self.iconColor = entity.iconColor
        self.iconBackgroundColor = entity.iconBackgroundColor
        self.iconStrokeColor = entity.iconStrokeColor
        self.lineColor = entity.lineColor
        self.lineCirclesColor = entity.lineCirclesColor
        self.dotColor = entity.dotColor
        self.dotStrokeColor = entity.dotStrokeColor
        self.qrForegroundColor = entity.qrForegroundColor
        self.qrBackgroundColor = entity.qrBackgroundColor
        self.progressForegroundColor = entity.progressForegroundColor
        self.progressBackgroundColor = entity.progressBackgroundColor
        self.chipTextColor = entity.chipTextColor
        self.chipBackgroundColor = entity.chipBackgroundColor
        self.chipStrokeColor = entity.chipStrokeColor
    }
    
    init(entity: CVEntityWrapper) {
        self.id = -1
        self.entity = entity.entity
        
        self.generalBlock = entity.generalBlock
        self.profileDescBlock = entity.profileDescBlock
        self.contactBlock = entity.contactBlock
        self.socialBlock = entity.socialBlock
        self.qrCodesBlock = entity.qrCodesBlock
        self.educationBlock = entity.educationBlock
        self.workBlock = entity.workBlock
        self.languagesBlock = entity.languagesBlock
        self.skillsBlock = entity.skillsBlock
        self.interestsBlock = entity.interestsBlock
        self.certificatesBlock = entity.certificatesBlock
        self.referencesBlock = entity.referencesBlock
        self.coverLetter = entity.coverLetter
        self.style = entity.style
        self.hasAdditionalBlock = entity.hasAdditionalBlock
        self.nameFont = entity.nameFont
        self.headersFont = entity.headersFont
        self.textFont = entity.textFont
        self.nameSize = entity.nameSize
        self.headersSize = entity.headersSize
        self.textSize = entity.textSize
        self.marginsSize = entity.marginsSize
        self.isHeadersBold = entity.isHeadersBold
        self.isHeadersUppercased = entity.isHeadersUppercased
        self.isHeadersItalic = entity.isHeadersItalic
        self.headerDotAdded = entity.headerDotAdded
        self.headerLineAdded = entity.headerLineAdded
        self.headerLinePosition = entity.headerLinePosition
        self.lineCirclesAdded = entity.lineCirclesAdded
        self.cornersRadius = entity.cornersRadius
        self.strokeWidth = entity.strokeWidth
        self.lineWidth = entity.lineWidth
        self.dotSize = entity.dotSize
        self.dotBackAdded = entity.dotBackAdded
        self.dotStrokeAdded = entity.dotStrokeAdded
        self.progressBarStyle = entity.progressBarStyle
        self.progressBarPercentAdded = entity.progressBarPercentAdded
        self.progressHeight = entity.progressHeight
        self.iconSize = entity.iconSize
        self.iconBackAdded = entity.iconBackAdded
        self.iconStrokeAdded = entity.iconStrokeAdded
        self.iconIsBold = entity.iconIsBold
        self.chipBackAdded = entity.chipBackAdded
        self.chipStrokeAdded = entity.chipStrokeAdded
        self.textResume = entity.textResume
        self.textCV = entity.textCV
        self.textProfile = entity.textProfile
        self.textThankYou = entity.textThankYou
        self.mainColor = entity.mainColor
        self.headerTextColor = entity.headerTextColor
        self.mainTextColor = entity.mainTextColor
        self.iconColor = entity.iconColor
        self.iconBackgroundColor = entity.iconBackgroundColor
        self.iconStrokeColor = entity.iconStrokeColor
        self.lineColor = entity.lineColor
        self.lineCirclesColor = entity.lineCirclesColor
        self.dotColor = entity.dotColor
        self.dotStrokeColor = entity.dotStrokeColor
        self.qrForegroundColor = entity.qrForegroundColor
        self.qrBackgroundColor = entity.qrBackgroundColor
        self.progressForegroundColor = entity.progressForegroundColor
        self.progressBackgroundColor = entity.progressBackgroundColor
        self.chipTextColor = entity.chipTextColor
        self.chipBackgroundColor = entity.chipBackgroundColor
        self.chipStrokeColor = entity.chipStrokeColor
    }
    
    init() {
        self.id = -1
        self.style = 0
        self.hasAdditionalBlock = false
        self.nameFont = 0
        self.headersFont = 0
        self.textFont = 0
        self.nameSize = 0
        self.headersSize = 0
        self.textSize = 0
        self.marginsSize = 0
        self.isHeadersBold = false
        self.isHeadersUppercased = false
        self.isHeadersItalic = false
        self.headerDotAdded = false
        self.headerLineAdded = false
        self.headerLinePosition = 0
        self.lineCirclesAdded = false
        self.cornersRadius = 0
        self.strokeWidth = 0
        self.lineWidth = 0
        self.dotSize = 0
        self.dotBackAdded = false
        self.dotStrokeAdded = false
        self.progressBarStyle = 0
        self.progressBarPercentAdded = false
        self.progressHeight = 0
        self.iconSize = 0
        self.iconBackAdded = false
        self.iconStrokeAdded = false
        self.iconIsBold = false
        self.chipBackAdded = false
        self.chipStrokeAdded = false
        self.textResume = ""
        self.textCV = ""
        self.textProfile = ""
        self.textThankYou = ""
        self.mainColor = ""
        self.headerTextColor = ""
        self.mainTextColor = ""
        self.iconColor = ""
        self.iconBackgroundColor = ""
        self.iconStrokeColor = ""
        self.lineColor = ""
        self.lineCirclesColor = ""
        self.dotColor = ""
        self.dotStrokeColor = ""
        self.qrForegroundColor = ""
        self.qrBackgroundColor = ""
        self.progressForegroundColor = ""
        self.progressBackgroundColor = ""
        self.chipTextColor = ""
        self.chipBackgroundColor = ""
        self.chipStrokeColor = ""
    }
    
    static func == (lhs: CVEntityWrapper, rhs: CVEntityWrapper) -> Bool {
        return false
    }
//    
//    static func == (lhs: CVEntityWrapper, rhs: CVEntityWrapper) -> Bool {
//        var isSame = lhs.id == rhs.id && lhs.wrapperName == rhs.wrapperName && lhs.style == rhs.style && lhs.hasAdditionalBlock == rhs.hasAdditionalBlock && lhs.color == rhs.color && lhs.headersFont == rhs.headersFont && lhs.textFont == rhs.textFont && lhs.nameSize == rhs.nameSize && lhs.headersSize == rhs.headersSize && lhs.textSize == rhs.textSize && lhs.isHeadersUppercased == rhs.isHeadersUppercased && lhs.isHeadersItalic == rhs.isHeadersItalic && lhs.styleGeneral == rhs.styleGeneral && lhs.styleDescription == rhs.styleDescription && lhs.styleContact == rhs.styleContact && lhs.styleSocial == rhs.styleSocial && lhs.styleQRCodes == rhs.styleQRCodes && lhs.styleEducation == rhs.styleEducation && lhs.styleWork == rhs.styleWork && lhs.styleLanguages == rhs.styleLanguages && lhs.styleSkills == rhs.styleSkills && lhs.styleInterests == rhs.styleInterests && lhs.styleCertificates == rhs.styleCertificates && lhs.textResume == rhs.textResume && lhs.textCV == rhs.textCV && lhs.textProfile == rhs.textProfile && lhs.textThankYou == rhs.textThankYou
//        
//        if isSame {
//            if let blockL = lhs.coverLetter, let blockR = rhs.coverLetter {
//                isSame = blockL.text == blockR.text && blockL.textCoverLetter == blockR.textCoverLetter
//            }
//        }
//        if isSame {
//            if let blockL = lhs.generalBlock, let blockR = rhs.generalBlock {
//                isSame = blockL.name == blockR.name && blockL.location == blockR.location && blockL.jobTitle == blockR.jobTitle && blockL.photoId == blockR.photoId && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//            }
//        }
//        if isSame {
//            if let blockL = lhs.profileDescBlock, let blockR = rhs.profileDescBlock {
//                isSame = blockL.profileDescription == blockR.profileDescription && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page && blockL.textAboutMe == blockR.textAboutMe
//            }
//        }
//        if isSame {
//            if let blockL = lhs.contactBlock, let blockR = rhs.contactBlock {
//                isSame = blockL.email == blockR.email && blockL.phone == blockR.phone && blockL.websiteLink == blockR.websiteLink && blockL.websiteQrCodeId == blockR.websiteQrCodeId && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page && blockL.textContact == blockR.textContact && blockL.textEmail == blockR.textEmail && blockL.textPhone == blockR.textPhone && blockL.textWebsite == blockR.textWebsite
//            }
//        }
//        if isSame {
//            if let blockL = lhs.socialBlock, let blockR = rhs.socialBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.link == itemR.link && itemL.media == itemR.media && itemL.qrCodeId == itemR.qrCodeId && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position && itemL.page == itemR.page
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.qrCodesBlock, let blockR = rhs.qrCodesBlock {
//                isSame = blockL.qrCodes.count == blockR.qrCodes.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.qrCodes.count {
//                        let itemL = blockL.qrCodes[i]
//                        let itemR = blockR.qrCodes[i]
//                        isSame = itemL == itemR
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.educationBlock, let blockR = rhs.educationBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.desc == itemR.desc && itemL.level == itemR.level && itemL.institution == itemR.institution && itemL.logoId == itemR.logoId && itemL.fieldOfStudy == itemR.fieldOfStudy && itemL.degree == itemR.degree && itemL.startDate == itemR.startDate && itemL.endDate == itemR.endDate && itemL.isStillLearning == itemR.isStillLearning && itemL.gpa == itemR.gpa && itemL.coursework == itemR.coursework && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position && itemL.page == itemR.page
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.workBlock, let blockR = rhs.workBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.desc == itemR.desc && itemL.jobTitle == itemR.jobTitle && itemL.company == itemR.company && itemL.iconId == itemR.iconId && itemL.location == itemR.location && itemL.startDate == itemR.startDate && itemL.endDate == itemR.endDate && itemL.isStillWorking == itemR.isStillWorking && itemL.responsibilities == itemR.responsibilities && itemL.remote == itemR.remote && itemL.partTime == itemR.partTime && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position && itemL.page == itemR.page
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.languagesBlock, let blockR = rhs.languagesBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.langId == itemR.langId && itemL.name == itemR.name && itemL.level == itemR.level && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position && itemL.page == itemR.page
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.skillsBlock, let blockR = rhs.skillsBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.name == itemR.name && itemL.level == itemR.level && itemL.iconId == itemR.iconId &&  itemL.category == itemR.category && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.interestsBlock, let blockR = rhs.interestsBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.name == itemR.name && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.certificatesBlock, let blockR = rhs.certificatesBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.name == itemR.name && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        if isSame {
//            if let blockL = lhs.referencesBlock, let blockR = rhs.referencesBlock {
//                isSame = blockL.list.count == blockR.list.count && blockL.isAdded == blockR.isAdded && blockL.position == blockR.position && blockL.isMainBlock == blockR.isMainBlock && blockL.page == blockR.page
//                if isSame {
//                    for i in 0..<blockL.list.count {
//                        let itemL = blockL.list[i]
//                        let itemR = blockR.list[i]
//                        isSame = itemL.referralName == itemR.referralName && itemL.company == itemR.company && itemL.email == itemR.email && itemL.phone == itemR.phone && itemL.isAdded == itemR.isAdded && itemL.position == itemR.position
//                        if !isSame {
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        return isSame
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(wrapperName)
    }
    
    static func getDefault () -> CVEntityWrapper {
        return CVEntityWrapper(entity: nil, id: -1, wrapperName: "Name", generalBlock: GeneralInfoBlockEntityWrapper.getDefault(position: 0, isMainBlock: true), profileDescBlock: ProfileDescriptionBlockEntityWrapper.getDefault(position: 1, isMainBlock: true), contactBlock: ContactInfoBlockEntityWrapper.getDefault(position: 2, isMainBlock: true), socialBlock: SocialMediaBlockEntityWrapper.getDefault(position: 3, isMainBlock: true), qrCodesBlock: QRCodesBlockEntityWrapper.getDefault(position: 4, isMainBlock: true), educationBlock: EducationBlockEntityWrapper.getDefault(position: 5, isMainBlock: true), workBlock: WorkBlockEntityWrapper.getDefault(position: 6, isMainBlock: true), languagesBlock: LanguagesBlockEntityWrapper.getDefault(position: 7, isMainBlock: true), skillsBlock: SkillsBlockEntityWrapper.getDefault(position: 8, isMainBlock: true), interestsBlock: InterestsBlockEntityWrapper.getDefault(position: 9, isMainBlock: true), certificatesBlock: CertificatesBlockEntityWrapper.getDefault(position: 10, isMainBlock: true), referencesBlock: ReferencesBlockEntityWrapper.getDefault(position: 0, isMainBlock: true), coverLetter: CoverLetterEntityWrapper.getDefault(), style: 0, hasAdditionalBlock: false, nameFont: 0, headersFont: 0, textFont: 0, nameSize: 64, headersSize: 24, textSize: 14, marginsSize: 12, isHeadersBold: true, isHeadersUppercased: true, isHeadersItalic: true, headerDotAdded: true, headerLineAdded: true, headerLinePosition: 0, lineCirclesAdded: true, cornersRadius: 12, strokeWidth: 2, lineWidth: 3, dotSize: 5, dotBackAdded: true, dotStrokeAdded: false, progressBarStyle: 0, progressBarPercentAdded: true, progressHeight: 8, iconSize: 24, iconBackAdded: true, iconStrokeAdded: true, iconIsBold: true, chipBackAdded: true, chipStrokeAdded: false, textResume: NSLocalizedString("resume", comment: ""), textCV: NSLocalizedString("cv", comment: ""), textProfile: NSLocalizedString("profile", comment: ""), textThankYou: NSLocalizedString("thank_you", comment: ""), mainColor: "#FF23CA", headerTextColor: "#000000", mainTextColor: "", lineColor: "#CC0000", lineCirclesColor: "", dotColor: "", dotStrokeColor: "", iconColor: "", iconBackgroundColor: "", iconStrokeColor: "", qrForegroundColor: "", qrBackgroundColor: "", progressForegroundColor: "", progressBackgroundColor: "", chipTextColor: "", chipBackgroundColor: "", chipStrokeColor: "")
    }
}
