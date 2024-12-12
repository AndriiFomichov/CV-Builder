//
//  CertificateBlockItemEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class CertificateBlockItemEntityWrapper {
    
    var entity: CertificateBlockItemEntity?
    
    var name: String
    var isAdded: Bool
    var position: Int
    
    init(entity: CertificateBlockItemEntity?, name: String, isAdded: Bool, position: Int) {
        self.entity = entity
        self.name = name
        self.isAdded = isAdded
        self.position = position
    }
    
    init(entity: CertificateBlockItemEntity) {
        self.entity = entity
        self.name = entity.name
        self.isAdded = entity.isAdded
        self.position = entity.position
    }
    
    static func getDefault (position: Int) -> CertificateBlockItemEntityWrapper {
        return CertificateBlockItemEntityWrapper(entity: nil, name: position == 0 ? NSLocalizedString("dummy_certificate_one", comment: "") : NSLocalizedString("dummy_certificate_two", comment: ""), isAdded: true, position: position)
    }
}
