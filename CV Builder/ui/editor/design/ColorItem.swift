//
//  ColorItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 02.12.2024.
//

import Foundation

class ColorItem {
    
    var id: Int
    var palette: Palette
    var isSelected: Bool
    
    init(id: Int, palette: Palette, isSelected: Bool) {
        self.id = id
        self.palette = palette
        self.isSelected = isSelected
    }
    
    static func getDefault () -> ColorItem {
        return ColorItem(id: 0, palette: PreloadedDatabase.getPalettesByStyleId(id: 0)[0], isSelected: true)
    }
}
