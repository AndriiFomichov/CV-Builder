//
//  ReferenceItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class ReferenceItem {
    
    var entity: ReferenceEntity
    
    var referralName: String
    var company: String
    var email: String
    var phone: String
    
    var position: Int
    
    init(entity: ReferenceEntity) {
        self.entity = entity
        self.referralName = entity.referralName
        self.company = entity.company
        self.email = entity.email
        self.phone = entity.phone
        self.position = entity.position
    }
    
    static func getDefault () -> ReferenceItem {
        return ReferenceItem(entity: ReferenceEntity(referralName: "Name", company: "Company", email: "Mail", phone: "", position: 0))
    }
}
