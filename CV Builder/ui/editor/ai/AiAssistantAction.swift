//
//  AiAssistantAction.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiAssistantAction {
    
    var id: Int
    var header: String
    var description: String
    var icon: String
    var clickHandler: () -> Void
    
    init(id: Int, header: String, description: String, icon: String, clickHandler: @escaping () -> Void) {
        self.id = id
        self.header = header
        self.description = description
        self.icon = icon
        self.clickHandler = clickHandler
    }
    
    static func getDefault () -> AiAssistantAction {
        return AiAssistantAction(id: 0, header: "Header", description: "Description", icon: "gear", clickHandler: {})
    }
}
