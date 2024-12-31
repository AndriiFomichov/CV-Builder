//
//  CertificatesBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class CertificatesBlockEntityWrapper {
    
    var entity: CertificatesBlockEntity?
    
    var list: [CertificateBlockItemEntityWrapper]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textCertificates: String
    
    var styleIsBulletedList: Bool
    var styleHeaderPosition: Int

    init(entity: CertificatesBlockEntity?, list: [CertificateBlockItemEntityWrapper], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textCertificates: String, styleIsBulletedList: Bool, styleHeaderPosition: Int) {
        self.entity = entity
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textCertificates = textCertificates
        self.styleIsBulletedList = styleIsBulletedList
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: CertificatesBlockEntity) {
        self.entity = entity
        if let list = entity.list {
            var items: [CertificateBlockItemEntityWrapper] = []
            for item in list {
                items.append(CertificateBlockItemEntityWrapper(entity: item))
            }
            self.list = items
        } else {
            self.list = []
        }
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textCertificates = entity.textCertificates
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> CertificatesBlockEntityWrapper {
        return CertificatesBlockEntityWrapper(entity: nil, list: [ CertificateBlockItemEntityWrapper.getDefault(position: 0) ], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, textCertificates: NSLocalizedString("languages", comment: ""), styleIsBulletedList: true, styleHeaderPosition: 0)
    }
}
