//
//  LanguageEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class LanguageEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var langId: Int
    var name: String
    var level: Int
    
    var position: Int
    
    init(langId: Int, name: String, level: Int, position: Int) {
        self.langId = langId
        self.name = name
        self.level = level
        self.position = position
    }
}
