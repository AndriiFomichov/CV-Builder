//
//  Interest.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class Interest {
    
    var name: String
    var icon: String
    var isSelected: Bool
    
    init(name: String, icon: String, isSelected: Bool) {
        self.name = name
        self.icon = icon
        self.isSelected = isSelected
    }
    
    static func getDefault () -> Interest {
        return Interest(name: "Hiking", icon: "square.and.arrow.up.badge.clock.fill", isSelected: true)
    }
}
