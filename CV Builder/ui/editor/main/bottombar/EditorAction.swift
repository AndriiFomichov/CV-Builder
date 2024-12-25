//
//  EditorAction.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import Foundation

class EditorAction {
    
    var id: Int
    var name: String
    var icon: String
    var isIconSystem: Bool
    var clickHandler: () -> Void
    
    init(id: Int, name: String, icon: String, isIconSystem: Bool, clickHandler: @escaping () -> Void) {
        self.id = id
        self.name = name
        self.icon = icon
        self.isIconSystem = isIconSystem
        self.clickHandler = clickHandler
    }
    
    static func getDefault () -> EditorAction {
        return EditorAction(id: 0, name: "Assistant", icon: "gear", isIconSystem: true, clickHandler: {})
    }
}
