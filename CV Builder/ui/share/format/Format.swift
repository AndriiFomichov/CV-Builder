//
//  Format.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation
import SwiftUI

class Format {
    
    var position: Int
    var icon: String
    var header: String
    var description: String
    var color: Color
    var isRecommended: Bool
    var isSelected: Bool
    
    init(position: Int, icon: String, header: String, description: String, color: Color, isRecommended: Bool, isSelected: Bool) {
        self.position = position
        self.icon = icon
        self.header = header
        self.description = description
        self.color = color
        self.isRecommended = isRecommended
        self.isSelected = isSelected
    }
    
    static func getDefault () -> Format {
        return Format(position: 0, icon: "icon_pdf", header: "PDF", description: "Format of file", color: Color.yellow, isRecommended: true, isSelected: false)
    }
}
