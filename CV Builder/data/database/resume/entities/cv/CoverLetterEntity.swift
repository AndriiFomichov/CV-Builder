//
//  CoverLetterEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation
import SwiftData

@Model
class CoverLetterEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var text: String
    
    var textCoverLetter: String
    
    var textSize: Int
    
    init(text: String, textCoverLetter: String, textSize: Int) {
        self.text = text
        self.textCoverLetter = textCoverLetter
        self.textSize = textSize
    }
    
    init(entity: CoverLetterEntity) {
        self.text = entity.text
        self.textCoverLetter = entity.textCoverLetter
        self.textSize = entity.textSize
    }
}
