//
//  BlockViewGetter.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.11.2024.
//

import SwiftUI

class BlockViewGetter {
    
    @MainActor
    static func getBlockByPosition (cv: CVEntityWrapper, position: Int, page: Int = 0, isMainBlock: Bool, headerTextColor: String, mainTextColor: String, blockBackgroundColor: String, blockStrokeColor: String, addBlockPadding: Bool = false) -> AnyView? {
        
        if let profileDescBlock = cv.profileDescBlock, profileDescBlock.position == position, profileDescBlock.isMainBlock == isMainBlock, profileDescBlock.page == page {
            if profileDescBlock.isAdded {
                return AnyView(ProfileDescriptionBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let contactBlock = cv.contactBlock, contactBlock.position == position, contactBlock.isMainBlock == isMainBlock, contactBlock.page == page {
            if contactBlock.isAdded {
                return AnyView(ContactInfoBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let socialBlock = cv.socialBlock, socialBlock.position == position, socialBlock.isMainBlock == isMainBlock, socialBlock.page == page {
            if socialBlock.isAdded {
                return AnyView(SocialMediaBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let qrCodesBlock = cv.qrCodesBlock, qrCodesBlock.position == position, qrCodesBlock.isMainBlock == isMainBlock, qrCodesBlock.page == page {
            if qrCodesBlock.isAdded {
                return AnyView(QRCodesBlockPreviewView(cv: cv, qrForegroundColor: cv.qrForegroundColor, qrBackgroundColor: cv.qrBackgroundColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let educationBlock = cv.educationBlock, educationBlock.position == position, educationBlock.isMainBlock == isMainBlock, educationBlock.page == page {
            if educationBlock.isAdded {
                return AnyView(EducationBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let workBlock = cv.workBlock, workBlock.position == position, workBlock.isMainBlock == isMainBlock, workBlock.page == page {
            if workBlock.isAdded {
                return AnyView(WorkBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let languagesBlock = cv.languagesBlock, languagesBlock.position == position, languagesBlock.isMainBlock == isMainBlock, languagesBlock.page == page {
            if languagesBlock.isAdded {
                return AnyView(LanguagesBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, progressForegroundColor: cv.progressForegroundColor, progressBackgroundColor: cv.progressBackgroundColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let skillsBlock = cv.skillsBlock, skillsBlock.position == position, skillsBlock.isMainBlock == isMainBlock, skillsBlock.isAdded, skillsBlock.page == page {
            if skillsBlock.isAdded {
                return AnyView(SkillsBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, progressForegroundColor: cv.progressForegroundColor, progressBackgroundColor: cv.progressBackgroundColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, chipBackgroundColor: cv.chipBackgroundColor, chipStrokeColor: cv.chipStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let interestsBlock = cv.interestsBlock, interestsBlock.position == position, interestsBlock.isMainBlock == isMainBlock, interestsBlock.page == page {
            if interestsBlock.isAdded {
                return AnyView(InterestsBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, chipBackgroundColor: cv.chipBackgroundColor, chipStrokeColor: cv.chipStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let certificatesBlock = cv.certificatesBlock, certificatesBlock.position == position, certificatesBlock.isMainBlock == isMainBlock, certificatesBlock.page == page {
            if certificatesBlock.isAdded {
                return AnyView(CertificatesBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        if let referencesBlock = cv.referencesBlock, referencesBlock.position == position, referencesBlock.isMainBlock == isMainBlock, referencesBlock.page == page {
            if referencesBlock.isAdded {
                return AnyView(ReferencesBlockPreviewView(cv: cv, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, addBlockPadding: addBlockPadding))
            } else {
                return AnyView(HStack{})
            }
        }
        return nil
    }
}