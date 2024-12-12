//
//  ContactInfoBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class ContactInfoBlockEntityWrapper {
    
    var entity: ContactInfoBlockEntity?
    
    var email: String
    var phone: String
    var websiteLink: String
    var websiteQrCodeId: Int
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textContact: String
    var textEmail: String
    var textPhone: String
    var textWebsite: String
    
    var styleIconAdded: Bool
    var styleHeaderAdded: Bool
    var styleHeaderPosition: Int

    init(entity: ContactInfoBlockEntity?, email: String, phone: String, websiteLink: String, websiteQrCodeId: Int, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textContact: String, textEmail: String, textPhone: String, textWebsite: String, styleIconAdded: Bool, styleHeaderAdded: Bool, styleHeaderPosition: Int) {
        self.entity = entity
        self.email = email
        self.phone = phone
        self.websiteLink = websiteLink
        self.websiteQrCodeId = websiteQrCodeId
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textContact = textContact
        self.textEmail = textEmail
        self.textPhone = textPhone
        self.textWebsite = textWebsite
        self.styleIconAdded = styleIconAdded
        self.styleHeaderAdded = styleHeaderAdded
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: ContactInfoBlockEntity) {
        self.entity = entity
        self.email = entity.email
        self.phone = entity.phone
        self.websiteLink = entity.websiteLink
        self.websiteQrCodeId = entity.websiteQrCodeId
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textContact = entity.textContact
        self.textEmail = entity.textEmail
        self.textPhone = entity.textPhone
        self.textWebsite = entity.textWebsite
        self.styleIconAdded = entity.styleIconAdded
        self.styleHeaderAdded = entity.styleHeaderAdded
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> ContactInfoBlockEntityWrapper {
        return ContactInfoBlockEntityWrapper(entity: nil, email: NSLocalizedString("dummy_email", comment: ""), phone: NSLocalizedString("dummy_phone", comment: ""), websiteLink: NSLocalizedString("dummy_website", comment: ""), websiteQrCodeId: -1, isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textContact: NSLocalizedString("about_me", comment: ""), textEmail: NSLocalizedString("email", comment: ""), textPhone: NSLocalizedString("phone", comment: ""), textWebsite: NSLocalizedString("website", comment: ""), styleIconAdded: true, styleHeaderAdded: true, styleHeaderPosition: 0)
    }
}