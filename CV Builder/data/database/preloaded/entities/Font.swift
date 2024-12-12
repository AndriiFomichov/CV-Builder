//
//  Font.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class Font {
    
    var id: Int
    var name: String
    var category: Int
    var italic: Int
    
    var isSelected = false
    
    init(id: Int, name: String, category: Int, italic: Int) {
        self.id = id
        self.name = name
        self.category = category
        self.italic = italic
    }
    
    static func getDefault () -> Font {
        return Font(id: 0, name: "Roboto Condensed", category: 0, italic: 1)
    }
}
