//
//  QRCodesBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class QRCodesBlockEntityWrapper {
    
    var entity: QRCodesBlockEntity?
    
    var qrCodes: [Int]
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var styleBackAdded: Bool

    init(entity: QRCodesBlockEntity?, qrCodes: [Int], isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, styleBackAdded: Bool) {
        self.entity = entity
        self.qrCodes = qrCodes
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.styleBackAdded = styleBackAdded
    }
    
    init(entity: QRCodesBlockEntity) {
        self.entity = entity
        var items: [Int] = []
        for item in entity.qrCodes {
            items.append(Int(item))
        }
        self.qrCodes = items
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.styleBackAdded = entity.styleBackAdded
    }
    
    static func getDefault (position: Int, isMainBlock: Bool) -> QRCodesBlockEntityWrapper {
        return QRCodesBlockEntityWrapper(entity: nil, qrCodes: [], isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, styleBackAdded: true)
    }
}
