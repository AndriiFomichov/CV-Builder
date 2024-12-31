//
//  Style.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class Style: Hashable {
    
    var id: Int
    
    var name: String
    var description: String
    var hasAdditionalBlock: Bool
    
    var margins: Int
    var fontName: Int
    var fontHeader: Int
    var fontText: Int
    var sizeName: Int
    var sizeHeader: Int
    var sizeText: Int
    var sizeCover: Int
    
    var isHeaderBold: Bool
    var isHeaderUppercased: Bool
    var isHeaderItalic: Bool
    
    var isHeaderDotAdded: Bool
    var isHeaderLineAdded: Bool
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
    
    var photoZoom: Float
    var photoFilterEnabled: Bool
    var photoStrokeAdded: Bool
    
    var profileDescHeaderAdded: Bool
    var profileDescHeaderPosition: Int
    var profileDescQuotesAdded: Bool
    
    var contactIconAdded: Bool
    var contactHeaderAdded: Bool
    var contactHeaderPosition: Int
    
    var socialIconAdded: Bool
    var socialHeaderPosition: Int
    
    var qrBackAdded: Bool
    
    var educationDateWithHeader: Bool
    var educationDateAfterHeader: Bool
    var educationDateSeparated: Bool
    var educationDateInBrackets: Bool
    var educationMonthDisplayed: Bool
    var educationDotsAdded: Bool
    var educationDescritpionAsBulleted: Bool
    var educationHeaderPosition: Int
    
    var workDateWithHeader: Bool
    var workDateAfterHeader: Bool
    var workDateSeparated: Bool
    var workDateInBrackets: Bool
    var workMonthDisplayed: Bool
    var workDotsAdded: Bool
    var workDescritpionAsBulleted: Bool
    var workHeaderPosition: Int
    
    var languagesIsBulletedList: Bool
    var languagesIsProgressAdded: Bool
    var languagesIsLevelAdded: Bool
    var languagesIconAdded: Bool
    var languagesHeaderPosition: Int
    
    var skillsIsBulletedList: Bool
    var skillsIsChips: Bool
    var skillsIsProgressAdded: Bool
    var skillsHeaderPosition: Int
    
    var interestsIsBulletedList: Bool
    var interestsIsChips: Bool
    var interestsHeaderPosition: Int
    
    var certificatesIsBulletedList: Bool
    var certificatesHeaderPosition: Int
    
    var referencesIsBulletedList: Bool
    var referencesHeaderPosition: Int
    
    var palettes: [Palette]
    
    var isSelected = false
    
    init(id: Int, name: String, description: String, hasAdditionalBlock: Bool, margins: Int, fontName: Int, fontHeader: Int, fontText: Int, sizeName: Int, sizeHeader: Int, sizeText: Int, sizeCover: Int, isHeaderBold: Bool, isHeaderUppercased: Bool, isHeaderItalic: Bool, isHeaderDotAdded: Bool, isHeaderLineAdded: Bool, headerLinePosition: Int, lineCirclesAdded: Bool, cornersRadius: Int, strokeWidth: Int, lineWidth: Int, dotSize: Int, dotBackAdded: Bool, dotStrokeAdded: Bool, progressBarStyle: Int, progressBarPercentAdded: Bool, progressHeight: Int, iconSize: Int, iconBackAdded: Bool, iconStrokeAdded: Bool, iconIsBold: Bool, chipBackAdded: Bool, chipStrokeAdded: Bool, photoZoom: Float, photoFilterEnabled: Bool, photoStrokeAdded: Bool, profileDescHeaderAdded: Bool, profileDescHeaderPosition: Int, profileDescQuotesAdded: Bool, contactIconAdded: Bool, contactHeaderAdded: Bool, contactHeaderPosition: Int, socialIconAdded: Bool, socialHeaderPosition: Int, qrBackAdded: Bool, educationDateWithHeader: Bool, educationDateAfterHeader: Bool, educationDateSeparated: Bool, educationDateInBrackets: Bool, educationMonthDisplayed: Bool, educationDotsAdded: Bool, educationDescritpionAsBulleted: Bool, educationHeaderPosition: Int, workDateWithHeader: Bool, workDateAfterHeader: Bool, workDateSeparated: Bool, workDateInBrackets: Bool, workMonthDisplayed: Bool, workDotsAdded: Bool, workDescritpionAsBulleted: Bool, workHeaderPosition: Int, languagesIsBulletedList: Bool, languagesIsProgressAdded: Bool, languagesIsLevelAdded: Bool, languagesIconAdded: Bool, languagesHeaderPosition: Int, skillsIsBulletedList: Bool, skillsIsChips: Bool, skillsIsProgressAdded: Bool, skillsHeaderPosition: Int, interestsIsBulletedList: Bool, interestsIsChips: Bool, interestsHeaderPosition: Int, certificatesIsBulletedList: Bool, certificatesHeaderPosition: Int, referencesIsBulletedList: Bool, referencesHeaderPosition: Int, palettes: [Palette], isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.hasAdditionalBlock = hasAdditionalBlock
        self.margins = margins
        self.fontName = fontName
        self.fontHeader = fontHeader
        self.fontText = fontText
        self.sizeName = sizeName
        self.sizeHeader = sizeHeader
        self.sizeText = sizeText
        self.sizeCover = sizeCover
        self.isHeaderBold = isHeaderBold
        self.isHeaderUppercased = isHeaderUppercased
        self.isHeaderItalic = isHeaderItalic
        self.isHeaderDotAdded = isHeaderDotAdded
        self.isHeaderLineAdded = isHeaderLineAdded
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
        self.photoZoom = photoZoom
        self.photoFilterEnabled = photoFilterEnabled
        self.photoStrokeAdded = photoStrokeAdded
        self.profileDescHeaderAdded = profileDescHeaderAdded
        self.profileDescHeaderPosition = profileDescHeaderPosition
        self.profileDescQuotesAdded = profileDescQuotesAdded
        self.contactIconAdded = contactIconAdded
        self.contactHeaderAdded = contactHeaderAdded
        self.contactHeaderPosition = contactHeaderPosition
        self.socialIconAdded = socialIconAdded
        self.socialHeaderPosition = socialHeaderPosition
        self.qrBackAdded = qrBackAdded
        self.educationDateWithHeader = educationDateWithHeader
        self.educationDateAfterHeader = educationDateAfterHeader
        self.educationDateSeparated = educationDateSeparated
        self.educationDateInBrackets = educationDateInBrackets
        self.educationMonthDisplayed = educationMonthDisplayed
        self.educationDotsAdded = educationDotsAdded
        self.educationDescritpionAsBulleted = educationDescritpionAsBulleted
        self.educationHeaderPosition = educationHeaderPosition
        self.workDateWithHeader = workDateWithHeader
        self.workDateAfterHeader = workDateAfterHeader
        self.workDateSeparated = workDateSeparated
        self.workDateInBrackets = workDateInBrackets
        self.workMonthDisplayed = workMonthDisplayed
        self.workDotsAdded = workDotsAdded
        self.workDescritpionAsBulleted = workDescritpionAsBulleted
        self.workHeaderPosition = workHeaderPosition
        self.languagesIsBulletedList = languagesIsBulletedList
        self.languagesIconAdded = languagesIconAdded
        self.languagesIsProgressAdded = languagesIsProgressAdded
        self.languagesIsLevelAdded = languagesIsLevelAdded
        self.languagesHeaderPosition = languagesHeaderPosition
        self.skillsIsBulletedList = skillsIsBulletedList
        self.skillsIsChips = skillsIsChips
        self.skillsIsProgressAdded = skillsIsProgressAdded
        self.skillsHeaderPosition = skillsHeaderPosition
        self.interestsIsBulletedList = interestsIsBulletedList
        self.interestsIsChips = interestsIsChips
        self.interestsHeaderPosition = interestsHeaderPosition
        self.certificatesIsBulletedList = certificatesIsBulletedList
        self.certificatesHeaderPosition = certificatesHeaderPosition
        self.referencesIsBulletedList = referencesIsBulletedList
        self.referencesHeaderPosition = referencesHeaderPosition
        self.palettes = palettes
        self.isSelected = isSelected
    }
    
    static func == (lhs: Style, rhs: Style) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func getDefault () -> Style {
        return PreloadedDatabase.getStyleId(id: 0)
    }
}
