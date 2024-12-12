//
//  Language.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class Language {
    
    var langId: Int
    var name: String
    var icon: String
    var key: String
    var isSelected: Bool
    
    init(langId: Int, name: String, icon: String, key: String, isSelected: Bool) {
        self.langId = langId
        self.name = name
        self.icon = icon
        self.key = key
        self.isSelected = isSelected
    }
    
    static func getDefault () -> Language {
        return Language(langId: 13, name: "Ukraine", icon: "uk_flag_icon", key: "Ukraine", isSelected: true)
    }
}
