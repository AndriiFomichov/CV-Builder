//
//  ProfileItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import Foundation

class ProfileItem {
    
    var header: String
    var description: String
    var icon: String
    var progress: CGFloat
    
    init(header: String, description: String, icon: String, progress: CGFloat) {
        self.header = header
        self.description = description
        self.icon = icon
        self.progress = progress
    }
    
    static func getDefault () -> ProfileItem {
        return ProfileItem(header: "Header", description: "description", icon: "gear", progress: 0.2)
    }
}
