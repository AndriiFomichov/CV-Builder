//
//  CertificateItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation

class CertificateItem {
    
    var entity: CertificateEntity
    
    var name: String
    var position: Int
    
    init(entity: CertificateEntity) {
        self.entity = entity
        self.name = entity.name
        self.position = entity.position
    }
    
    static func getDefault () -> CertificateItem {
        return CertificateItem(entity: CertificateEntity(name: "Certificate", position: 0))
    }
}
