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
    
    init(text: String, textCoverLetter: String) {
        self.text = text
        self.textCoverLetter = textCoverLetter
    }
    
    init(entity: CoverLetterEntity) {
        self.text = entity.text
        self.textCoverLetter = entity.textCoverLetter
    }
}
