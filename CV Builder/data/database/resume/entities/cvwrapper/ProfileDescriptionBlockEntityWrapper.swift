//
//  ProfileDescriptionBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class ProfileDescriptionBlockEntityWrapper {
    
    var entity: ProfileDescriptionBlockEntity?
    
    var profileDescription: String
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int

    var textAboutMe: String
    
    var styleHeaderAdded: Bool
    var styleHeaderPosition: Int
    var styleQuotesAdded: Bool
    
    init(entity: ProfileDescriptionBlockEntity?, profileDescription: String, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textAboutMe: String, styleHeaderAdded: Bool, styleHeaderPosition: Int, styleQuotesAdded: Bool) {
        self.entity = entity
        self.profileDescription = profileDescription
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textAboutMe = textAboutMe
        self.styleHeaderAdded = styleHeaderAdded
        self.styleHeaderPosition = styleHeaderPosition
        self.styleQuotesAdded = styleQuotesAdded
    }
    
    init(entity: ProfileDescriptionBlockEntity) {
        self.entity = entity
        self.profileDescription = entity.profileDescription
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textAboutMe = entity.textAboutMe
        self.styleHeaderAdded = entity.styleHeaderAdded
        self.styleHeaderPosition = entity.styleHeaderPosition
        self.styleQuotesAdded = entity.styleQuotesAdded
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> ProfileDescriptionBlockEntityWrapper {
        return ProfileDescriptionBlockEntityWrapper(entity: nil, profileDescription: NSLocalizedString("dummy_job_description", comment: ""), isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textAboutMe: NSLocalizedString("about_me", comment: ""), styleHeaderAdded: true, styleHeaderPosition: 0, styleQuotesAdded: false)
    }
}
