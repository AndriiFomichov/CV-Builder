//
//  SocialMedia.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class SocialMedia {
    
    var id: Int
    var name: String
    var icon: String
    var isSelected: Bool
    
    init(id: Int, name: String, icon: String, isSelected: Bool) {
        self.id = id
        self.name = name
        self.icon = icon
        self.isSelected = isSelected
    }
    
    static func getDefault () -> SocialMedia {
        return SocialMedia(id: 0, name: "Facebook", icon: "facebook_icon", isSelected: false)
    }
}
