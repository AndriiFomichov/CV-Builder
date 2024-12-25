//
//  CoverLetterEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation

class CoverLetterEntityWrapper {
    
    var entity: CoverLetterEntity?
    
    var text: String
    
    var textCoverLetter: String
    
    var textSize: Int
    
    init(entity: CoverLetterEntity?, text: String, textCoverLetter: String, textSize: Int) {
        self.entity = entity
        self.text = text
        self.textCoverLetter = textCoverLetter
        self.textSize = textSize
    }
    
    init(entity: CoverLetterEntity) {
        self.entity = entity
        self.text = entity.text
        self.textCoverLetter = entity.textCoverLetter
        self.textSize = entity.textSize
    }
    
    static func getDefault () -> CoverLetterEntityWrapper {
        return CoverLetterEntityWrapper(entity: nil, text: "Cover letter text", textCoverLetter: NSLocalizedString("cover_letter", comment: ""), textSize: 12)
    }
}
