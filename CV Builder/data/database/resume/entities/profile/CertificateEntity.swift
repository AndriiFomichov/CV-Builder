//
//  CertificateEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class CertificateEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var name: String
    
    var position: Int
    
    init(name: String, position: Int) {
        self.name = name
        self.position = position
    }
}
