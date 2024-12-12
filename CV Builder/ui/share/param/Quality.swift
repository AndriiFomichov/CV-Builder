//
//  Quality.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation

class Quality {
    
    var id: Int
    var name: String
    var icon: String
    var isPremium: Bool
    var isPremiumVisible: Bool
    var isSelected: Bool
    
    init(id: Int, name: String, icon: String, isPremium: Bool, isPremiumVisible: Bool, isSelected: Bool) {
        self.id = id
        self.name = name
        self.icon = icon
        self.isPremium = isPremium
        self.isPremiumVisible = isPremiumVisible
        self.isSelected = isSelected
    }
    
    static func getDefault () -> Quality {
        return Quality(id: 0, name: "Compressed", icon: "briefcase.fill", isPremium: true, isPremiumVisible: true, isSelected: true)
    }
}
