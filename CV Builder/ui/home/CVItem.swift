//
//  CVItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import Foundation
import UIKit

class CVItem {
    
    let entity: CVEntity
    
    let previewOne: UIImage?
    let previewTwo: UIImage?
    
    let targetJob: String
    let targetCompany: String
    
    init(entity: CVEntity, previewOne: UIImage?, previewTwo: UIImage?, targetJob: String, targetCompany: String) {
        self.entity = entity
        self.previewOne = previewOne
        self.previewTwo = previewTwo
        self.targetJob = targetJob
        self.targetCompany = targetCompany
    }
    
    static func getDefault () -> CVItem {
        return CVItem(entity: CVEntity.getDefault(), previewOne: UIImage(named: "style_preview_0"), previewTwo: UIImage(named: "style_preview_0"), targetJob: "Designer", targetCompany: "Coca Cola")
    }
}
