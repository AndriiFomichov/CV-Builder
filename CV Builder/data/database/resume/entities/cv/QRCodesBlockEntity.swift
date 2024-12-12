//
//  QRCodesBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class QRCodesBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var qrCodes: [Int]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var styleBackAdded: Bool

    init(qrCodes: [Int], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, styleBackAdded: Bool) {
        self.qrCodes = qrCodes
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.styleBackAdded = styleBackAdded
    }
    
    init(entity: QRCodesBlockEntity) {
        self.qrCodes = entity.qrCodes
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.styleBackAdded = entity.styleBackAdded
    }
}
