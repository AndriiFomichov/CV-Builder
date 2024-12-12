//
//  ReferenceEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class ReferenceEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var referralName: String
    var company: String
    var email: String
    var phone: String
    
    var position: Int
    
    init(referralName: String, company: String, email: String, phone: String, position: Int) {
        self.referralName = referralName
        self.company = company
        self.email = email
        self.phone = phone
        self.position = position
    }
}
