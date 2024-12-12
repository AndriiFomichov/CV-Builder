//
//  ReferenceBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class ReferenceBlockItemEntityWrapper {
    
    var entity: ReferenceBlockItemEntity?
    
    var referralName: String
    var company: String
    var email: String
    var phone: String
    var isAdded: Bool
    var position: Int
    
    init(entity: ReferenceBlockItemEntity?, referralName: String, company: String, email: String, phone: String, isAdded: Bool, position: Int) {
        self.entity = entity
        self.referralName = referralName
        self.company = company
        self.email = email
        self.phone = phone
        self.isAdded = isAdded
        self.position = position
    }
    
    init(entity: ReferenceBlockItemEntity) {
        self.entity = entity
        self.referralName = entity.referralName
        self.company = entity.company
        self.email = entity.email
        self.phone = entity.phone
        self.isAdded = entity.isAdded
        self.position = entity.position
    }
    
    static func getDefault (position: Int) -> ReferenceBlockItemEntityWrapper {
        return ReferenceBlockItemEntityWrapper(entity: nil, referralName: NSLocalizedString("dummy_referral_name", comment: ""), company: NSLocalizedString("dummy_referral_company", comment: ""), email: NSLocalizedString("dummy_referral_email", comment: ""), phone: NSLocalizedString("dummy_referral_phone", comment: ""), isAdded: true, position: position)
    }
}
