//
//  CVEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class CVEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var generalBlock: GeneralInfoBlockEntity?
    var profileDescBlock: ProfileDescriptionBlockEntity?
    var contactBlock: ContactInfoBlockEntity?
    var socialBlock: SocialMediaBlockEntity?
    var qrCodesBlock: QRCodesBlockEntity?
    var educationBlock: EducationBlockEntity?
    var workBlock: WorkBlockEntity?
    var languagesBlock: LanguagesBlockEntity?
    var skillsBlock: SkillsBlockEntity?
    var interestsBlock: InterestsBlockEntity?
    var certificatesBlock: CertificatesBlockEntity?
    var referencesBlock: ReferencesBlockEntity?
    
    var coverLetter: CoverLetterEntity?

    var name: String
    var lastModified: Date
    var bookmarked: Bool
    
    var tagretJob: String
    var tagretCompany: String
    
    @Attribute(.externalStorage) var previewOne: Data?
    @Attribute(.externalStorage) var previewTwo: Data?
    
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
    
    init(entity: CVEntity) {
        self.name = entity.name
        self.lastModified = entity.lastModified
        self.bookmarked = entity.bookmarked
        self.tagretJob = entity.tagretJob
        self.tagretCompany = entity.tagretCompany
        self.previewOne = entity.previewOne
        self.previewTwo = entity.previewTwo
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
    
    init(generalBlock: GeneralInfoBlockEntity?, profileDescBlock: ProfileDescriptionBlockEntity?, contactBlock: ContactInfoBlockEntity?, socialBlock: SocialMediaBlockEntity?, qrCodesBlock: QRCodesBlockEntity?, educationBlock: EducationBlockEntity?, workBlock: WorkBlockEntity?, languagesBlock: LanguagesBlockEntity?, skillsBlock: SkillsBlockEntity?, interestsBlock: InterestsBlockEntity?, certificatesBlock: CertificatesBlockEntity?, referencesBlock: ReferencesBlockEntity?, coverLetter: CoverLetterEntity?, name: String, lastModified: Date, bookmarked: Bool, tagretJob: String, tagretCompany: String, previewOne: Data?, previewTwo: Data?, style: Int, hasAdditionalBlock: Bool, nameFont: Int, headersFont: Int, textFont: Int, nameSize: Int, headersSize: Int, textSize: Int, marginsSize: Int, isHeadersBold: Bool, isHeadersUppercased: Bool, isHeadersItalic: Bool, headerDotAdded: Bool, headerLineAdded: Bool, headerLinePosition: Int, lineCirclesAdded: Bool, cornersRadius: Int, strokeWidth: Int, lineWidth: Int, dotSize: Int, dotBackAdded: Bool, dotStrokeAdded: Bool, progressBarStyle: Int, progressBarPercentAdded: Bool, iconSize: Int, iconBackAdded: Bool, iconStrokeAdded: Bool, iconIsBold: Bool, chipBackAdded: Bool, chipStrokeAdded: Bool, textResume: String, textCV: String, textProfile: String, textThankYou: String, mainColor: String, headerTextColor: String, mainTextColor: String, lineColor: String, lineCirclesColor: String, dotColor: String, dotStrokeColor: String, iconColor: String, iconBackgroundColor: String, iconStrokeColor: String, qrForegroundColor: String, qrBackgroundColor: String, progressForegroundColor: String, progressBackgroundColor: String, chipTextColor: String, chipBackgroundColor: String, chipStrokeColor: String) {
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
        self.name = name
        self.lastModified = lastModified
        self.bookmarked = bookmarked
        self.tagretJob = tagretJob
        self.tagretCompany = tagretCompany
        self.previewOne = previewOne
        self.previewTwo = previewTwo
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
    
    static func getDefault () -> CVEntity {
        return CVEntity(generalBlock: nil, profileDescBlock: nil, contactBlock: nil, socialBlock: nil, qrCodesBlock: nil, educationBlock: nil, workBlock: nil, languagesBlock: nil, skillsBlock: nil, interestsBlock: nil, certificatesBlock: nil, referencesBlock: nil, coverLetter: nil, name: "", lastModified: Date(), bookmarked: false, tagretJob: "", tagretCompany: "", previewOne: nil, previewTwo: nil, style: 0, hasAdditionalBlock: false, nameFont: 0, headersFont: 0, textFont: 0, nameSize: 14, headersSize: 14, textSize: 14, marginsSize: 12, isHeadersBold: true, isHeadersUppercased: true, isHeadersItalic: true, headerDotAdded: true, headerLineAdded: true, headerLinePosition: 0, lineCirclesAdded: true, cornersRadius: 12, strokeWidth: 2, lineWidth: 3, dotSize: 5, dotBackAdded: true, dotStrokeAdded: false, progressBarStyle: 0, progressBarPercentAdded: true, iconSize: 24, iconBackAdded: true, iconStrokeAdded: true, iconIsBold: true, chipBackAdded: true, chipStrokeAdded: false, textResume: "", textCV: "", textProfile: "", textThankYou: "", mainColor: "#FF23CA", headerTextColor: "", mainTextColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "", iconColor: "", iconBackgroundColor: "", iconStrokeColor: "", qrForegroundColor: "", qrBackgroundColor: "", progressForegroundColor: "", progressBackgroundColor: "", chipTextColor: "", chipBackgroundColor: "", chipStrokeColor: "")
    }
}
