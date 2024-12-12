//
//  CertificatesBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class CertificatesBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var list: [CertificateBlockItemEntity]?
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var textLanguages: String
    
    var styleIsBulletedList: Bool
    var styleHeaderPosition: Int
    
    init(list: [CertificateBlockItemEntity]?, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, textLanguages: String, styleIsBulletedList: Bool, styleHeaderPosition: Int) {
        self.list = list
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.textLanguages = textLanguages
        self.styleIsBulletedList = styleIsBulletedList
        self.styleHeaderPosition = styleHeaderPosition
    }
    
    init(entity: CertificatesBlockEntity) {
        self.list = []
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.textLanguages = entity.textLanguages
        self.styleIsBulletedList = entity.styleIsBulletedList
        self.styleHeaderPosition = entity.styleHeaderPosition
    }
}
