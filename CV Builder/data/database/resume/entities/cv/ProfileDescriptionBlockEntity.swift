//
//  ProfileDescriptionBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class ProfileDescriptionBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var profileDescription: String
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int

    var textAboutMe: String
    
    var styleHeaderAdded: Bool
    var styleHeaderPosition: Int
    var styleQuotesAdded: Bool
    
    init(profileDescription: String, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textAboutMe: String, styleHeaderAdded: Bool, styleHeaderPosition: Int, styleQuotesAdded: Bool) {
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
}
